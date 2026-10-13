import { promises as fs } from "node:fs";
import path from "node:path";
import { NextResponse } from "next/server";

export const dynamic = "force-dynamic";

const PROJECT_FILE = "app-store-screenshots.json";

function filePath() {
  return path.join(process.cwd(), PROJECT_FILE);
}

export async function GET() {
  try {
    const raw = await fs.readFile(filePath(), "utf8");
    const parsed = JSON.parse(raw);
    return NextResponse.json({ ok: true, state: parsed });
  } catch (e) {
    const code = (e as NodeJS.ErrnoException).code;
    if (code === "ENOENT") {
      return NextResponse.json({ ok: true, state: null });
    }
    return NextResponse.json(
      { ok: false, error: e instanceof Error ? e.message : String(e) },
      { status: 500 },
    );
  }
}

export async function POST(req: Request) {
  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ ok: false, error: "Invalid JSON" }, { status: 400 });
  }
  if (!body || typeof body !== "object" ||
      typeof (body as Record<string, unknown>).appName !== "string" ||
      !Array.isArray((body as Record<string, unknown>).locales) ||
      !(body as Record<string, unknown>).slidesByDevice) {
    return NextResponse.json({ ok: false, error: "Invalid project" }, { status: 400 });
  }
  try {
    const pretty = JSON.stringify(body, null, 2) + "\n";
    const temporary = `${filePath()}.${crypto.randomUUID()}.tmp`;
    await fs.writeFile(temporary, pretty, "utf8");
    await fs.rename(temporary, filePath());
    return NextResponse.json({ ok: true });
  } catch (e) {
    return NextResponse.json(
      { ok: false, error: e instanceof Error ? e.message : String(e) },
      { status: 500 },
    );
  }
}

import sharp from "sharp";

export async function POST(req: Request) {
  const bytes = Buffer.from(await req.arrayBuffer());
  if (bytes.length > 32 * 1024 * 1024 ||
      !bytes.subarray(0, 8).equals(Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]))) {
    return Response.json({ error: "Invalid PNG" }, { status: 400 });
  }
  try {
    // Chrome canvas PNGs retain an alpha channel even with alpha:false.
    const png = await sharp(bytes, { limitInputPixels: 20_000_000 }).removeAlpha().png().toBuffer();
    return new Response(new Uint8Array(png), {
      headers: { "Content-Type": "image/png", "Cache-Control": "no-store" },
    });
  } catch {
    return Response.json({ error: "Could not encode PNG" }, { status: 400 });
  }
}

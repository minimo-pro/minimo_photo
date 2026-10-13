"use client";
// Non-device store creatives, rendered at native size: /creative?kind=header|search|play
import * as React from "react";
import { useFitText } from "@/lib/use-fit-text";
import { storeCopy } from "@/lib/store-copy";
import { SlideCanvas } from "@/components/editor/slide-canvas";
import { themeById } from "@/lib/constants";
import type { ProjectState } from "@/lib/types";
import { Phone } from "@/components/editor/device-frames";

const FONT = "Pangolin, ui-rounded, system-ui, sans-serif";
const INK = "#272727";
const ACCENT = "#FC3636";

const CREATIVES = {
  header: { w: 3840, h: 1646 },
  search: { w: 3840, h: 2560 },
  play: { w: 1024, h: 500 },
} as const;
type Kind = keyof typeof CREATIVES;

const phoneShadow = "drop-shadow(0 40px 60px rgba(30,60,110,0.35))";

function Sky({ veil }: { veil: string }) {
  return (
    <>
      <img
        src="/brand/sky-wide.jpg"
        alt=""
        style={{
          position: "absolute",
          inset: 0,
          width: "100%",
          height: "100%",
          objectFit: "cover",
          objectPosition: "center bottom",
          filter: "blur(0.25vw) saturate(0.85)",
          transform: "scale(1.04)",
          transformOrigin: "center bottom",
        }}
      />
      <div style={{ position: "absolute", inset: 0, background: "rgba(241,242,246,0.24)" }} />
      <div style={{ position: "absolute", inset: 0, background: veil }} />
    </>
  );
}

function Headline({ size, align = "left", lines, fit }: { size: number; align?: "left" | "center"; lines: React.ReactNode; fit: boolean }) {
  const ref = useFitText(lines, { fontSize: size, fontFamily: FONT }, fit);
  return (
    <div
      ref={ref}
      data-fit-text={fit || undefined}
      style={{
        fontFamily: FONT, wordSpacing: "0.12em",
        fontSize: size,
        lineHeight: 1.08,
        color: INK,
        textAlign: align,
        whiteSpace: "pre-wrap",
        textShadow: "0 2px 30px rgba(255,255,255,0.6)",
      }}
    >
      {lines}
    </div>
  );
}

function BannerCopy({ text, size, color, fit, style }: { text: string; size: number; color: string; fit: boolean; style?: React.CSSProperties }) {
  const ref = useFitText(text, { fontSize: size, fontFamily: FONT }, fit);
  return <div ref={ref} data-fit-text={fit || undefined} style={{ fontFamily: FONT, wordSpacing: "0.12em", fontSize: size, color, whiteSpace: "nowrap", ...style }}>{text}</div>;
}

function PhoneAt({ src, x, y, width, rotation = 0, z = 1 }: { src: string; x: number; y: number; width: number; rotation?: number; z?: number }) {
  const Frame = Phone;
  return (
    <div style={{ position: "absolute", left: x, top: y, width, transform: `rotate(${rotation}deg)`, zIndex: z, filter: phoneShadow }}>
      <Frame src={src} hideEmpty />
    </div>
  );
}

function Header({ locale }: { locale: string }) {
  const t = (text: string) => storeCopy(text, locale);
  const IOS = `/screenshots/apple/iphone/${locale}`;
  const { w: W, h: H } = CREATIVES.header;
  const pw = H * 0.5;
  return (
    <>
      <Sky veil="linear-gradient(90deg, rgba(255,255,255,0.85) 0%, rgba(255,255,255,0.55) 38%, rgba(255,255,255,0) 60%)" />
      <div style={{ position: "absolute", left: W * 0.14, top: H * 0.27, width: W * 0.43, zIndex: 10 }}>
        <BannerCopy fit={true} text={t("100% on-device · no cloud")} size={H * 0.055} color={ACCENT} style={{ marginBottom: H * 0.02 }} />
        <Headline
          fit={true}
          size={H * 0.135}
          lines={
            <>
              {t("make your photos\nsmaller").split("\n")[0]}{"\n"}
              <span style={{ color: ACCENT }}>{t("smaller")}</span>
            </>
          }
        />
        <BannerCopy fit={true} text={t("Lighter photos. Moments stay.")} size={H * 0.05} color="#5A606C" style={{ marginTop: H * 0.035 }} />
      </div>
      <PhoneAt src={`${IOS}/02-advanced.png`} x={W * 0.59} y={H * 0.2} width={pw} rotation={-7} z={1} />
      <PhoneAt src={`${IOS}/09-result-dark.png`} x={W * 0.77} y={H * 0.2} width={pw} rotation={7} z={1} />
      <PhoneAt src={`${IOS}/04-result.png`} x={W * 0.68} y={H * 0.1} width={pw * 1.06} z={2} />
    </>
  );
}

function Search({ locale }: { locale: string }) {
  const t = (text: string) => storeCopy(text, locale);
  const IOS = `/screenshots/apple/iphone/${locale}`;
  const { w: W, h: H } = CREATIVES.search;
  const pw = W * 0.25;
  return (
    <>
      <Sky veil="linear-gradient(180deg, rgba(255,255,255,0.9) 0%, rgba(255,255,255,0.55) 22%, rgba(255,255,255,0) 42%)" />
      <div style={{ position: "absolute", left: 0, right: 0, top: H * 0.06, zIndex: 10 }}>
        <Headline
          fit={true}
          size={H * 0.105}
          align="center"
          lines={
            <>
              {t("make your photos\nsmaller").split("\n")[0]} <span style={{ color: ACCENT }}>{t("smaller")}</span>
            </>
          }
        />
        <BannerCopy fit={true} text={t("compress in batches · choose your quality · 100% on-device")} size={H * 0.045} color="#5A606C" style={{ marginTop: H * 0.015, textAlign: "center" }} />
      </div>
      <PhoneAt src={`${IOS}/01-settings.png`} x={W * 0.13} y={H * 0.36} width={pw} rotation={-6} />
      <PhoneAt src={`${IOS}/03-progress.png`} x={W * 0.62} y={H * 0.36} width={pw} rotation={6} />
      <PhoneAt src={`${IOS}/04-result.png`} x={W * 0.365} y={H * 0.3} width={pw * 1.08} z={2} />
    </>
  );
}

export default function CreativePage() {
  const [state, setState] = React.useState<ProjectState | null>(null);
  const [locale, setLocale] = React.useState("en");
  const [kind, setKind] = React.useState<Kind | null>(null);
  React.useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    setLocale(params.get("locale") || "en");
    fetch("/api/project").then(r => r.json()).then(data => setState(data.state));
    const k = params.get("kind") as Kind;
    setKind(k in CREATIVES ? k : "header");
  }, []);
  if (!kind || !state) return null;
  const { w, h } = CREATIVES[kind];
  return (
    <div style={{ position: "relative", width: w, height: h, overflow: "hidden", background: "#F1F2F6" }}>
      <style>{"nextjs-portal{display:none!important} body{margin:0}"}</style>
      {kind === "header" ? <Header locale={locale} /> : kind === "search" ? <Search locale={locale} /> : <SlideCanvas slide={state.slidesByDevice["feature-graphic"][0]} device="feature-graphic" orientation="portrait" theme={themeById(state.themeId)} locale={locale} appName={state.appName} appIcon={state.appIcon} hideEmpty />}
    </div>
  );
}

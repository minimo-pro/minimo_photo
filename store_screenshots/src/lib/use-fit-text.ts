"use client";
import * as React from "react";

// Preserve explicit line breaks when a translation needs more room.
export function useFitText(value: unknown, style: React.CSSProperties | undefined, enabled: boolean) {
  const ref = React.useRef<HTMLDivElement>(null);
  const fontSize = style?.fontSize;
  const fontFamily = style?.fontFamily;
  React.useEffect(() => {
    if (!enabled) return;
    let cancelled = false;
    void document.fonts.ready.then(() => {
      const el = ref.current;
      if (!el || cancelled) return;
      el.style.fontSize = typeof fontSize === "number" ? `${fontSize}px` : fontSize || "";
      const computed = getComputedStyle(el);
      const size = parseFloat(computed.fontSize);
      const canvas = document.createElement("canvas").getContext("2d")!;
      canvas.font = `${computed.fontWeight} ${size}px ${computed.fontFamily}`;
      const spacing = (v: string) => v === "normal" ? 0 : parseFloat(v) || 0;
      const wordSpacing = spacing(computed.wordSpacing);
      const letterSpacing = spacing(computed.letterSpacing);
      const width = Math.max(...el.innerText.split("\n").map(line =>
        canvas.measureText(line).width + Math.max(0, line.length - 1) * letterSpacing +
        (line.match(/ /g)?.length || 0) * wordSpacing));
      const padding = parseFloat(computed.paddingLeft) + parseFloat(computed.paddingRight);
      const parent = el.parentElement!;
      const parentStyle = getComputedStyle(parent);
      const available = parent.clientWidth - parseFloat(parentStyle.paddingLeft) - parseFloat(parentStyle.paddingRight);
      el.style.fontSize = `${size * Math.min(1, (available - 2) / Math.max(1, width + padding))}px`;
    });
    return () => { cancelled = true; };
  }, [value, fontSize, fontFamily, enabled]);
  return ref;
}

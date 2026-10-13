import project from "../../app-store-screenshots.json";
import { DEFAULT_LOCALE } from "./locale";
import type { Device, ProjectState, Slide } from "./types";

let _id = 0;
export const nid = () => `s_${Date.now().toString(36)}_${(_id++).toString(36)}`;

const en = (s: string) => ({ [DEFAULT_LOCALE]: s });

export const DEFAULT_PROJECT = project as ProjectState;

export function newSlide(layout: Slide["layout"] = "device-bottom"): Slide {
  return {
    id: nid(),
    layout,
    label: en("NEW"),
    headline: en("Edit this\nheadline."),
    screenshot: "",
  };
}

export function detectPlatform(device: Device): "ios" | "android" {
  return device === "iphone" || device === "ipad" || device.startsWith("duo-") ? "ios" : "android";
}

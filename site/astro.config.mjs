// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import rehypeMermaid from "rehype-mermaid-lite";

// https://astro.build/config
export default defineConfig({
  site: "https://jonathan-vella.github.io",
  base: "/microhack-agentic-infraops",
  trailingSlash: "always",
  markdown: {
    rehypePlugins: [rehypeMermaid],
  },
  integrations: [
    starlight({
      title: "APEX MicroHack",
      description:
        "1-day hands-on hackathon: Master IaC-driven Azure infrastructure delivery using platform engineering practices — accelerated by GitHub Copilot.",
      favicon: "/images/favicon.svg",
      logo: {
        src: "./src/assets/images/logo.svg",
      },
      editLink: {
        baseUrl:
          "https://github.com/jonathan-vella/microhack-agentic-infraops/edit/main/site/",
      },
      lastUpdated: true,
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/jonathan-vella/microhack-agentic-infraops",
        },
      ],
      expressiveCode: {
        styleOverrides: { borderRadius: "0.5rem" },
      },
      sidebar: [
        {
          label: "Getting Started",
          collapsed: true,
          autogenerate: { directory: "getting-started" },
        },
        {
          label: "Challenges",
          collapsed: true,
          autogenerate: { directory: "challenges" },
        },
        {
          label: "Guides",
          collapsed: true,
          autogenerate: { directory: "guides" },
        },
        {
          label: "Reference",
          collapsed: true,
          autogenerate: { directory: "reference" },
        },
        {
          label: "About",
          collapsed: true,
          autogenerate: { directory: "about" },
        },
      ],
      customCss: [
        "@fontsource/space-grotesk/400.css",
        "@fontsource/space-grotesk/700.css",
        "@fontsource/manrope/400.css",
        "@fontsource/manrope/700.css",
        "@fontsource/ibm-plex-mono/400.css",
        "@fontsource/ibm-plex-mono/500.css",
        "./src/styles/custom.css",
      ],
      components: {
        Footer: "./src/components/Footer.astro",
      },
    }),
  ],
});

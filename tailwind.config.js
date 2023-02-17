/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.js', './src/**/*.elm'],
  theme: {
    extend: {},
  },
  daisyui: {
    themes: [
      {
        croq: {
          "primary": "#22c55e",
          "secondary": "#ec4899",
          "accent": "#f59e0b",
          "neutral": "#f3f4f6",
          "base-100": "#FFFFFF",
          "info": "#3ABFF8",
          "success": "#36D399",
          "warning": "#FBBD23",
          "error": "#F87272",
        },
      },
    ],
  },
  plugins: [
    require("@tailwindcss/typography"),
    require("daisyui")],
}

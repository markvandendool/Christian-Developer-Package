// vite.config.js
export default {
  server: {
    port: 5173,
    open: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true
  },
  base: '/cubes/'
}

# ChordCubes Development Environment Setup

This document provides instructions for setting up a development environment for ChordCubes.

## Prerequisites

- **Node.js**: v18.x or higher
- **npm**: v9.x or higher
- **Git**: v2.30.0 or higher
- **Modern web browser**: Chrome, Firefox, Safari, or Edge (latest versions)
- **Code editor**: VS Code recommended with the following extensions:
  - ESLint
  - Prettier
  - JavaScript and TypeScript Language Features
  - Live Server
  - WebGL Shader Editor

## Installation

1. **Clone the repository**

```bash
git clone https://github.com/ChordCubes/ChordCubes-Enterprise.git
cd ChordCubes-Enterprise
```

2. **Install dependencies**

```bash
npm install
```

3. **Setup environment variables**

Create a `.env` file in the root directory with the following content:

```
# Development environment
NODE_ENV=development

# WebGL settings
WEBGL_DEBUG=true
WEBGL_RENDERER_PREFERENCE=high-performance

# Audio settings
AUDIO_SAMPLE_RATE=44100
AUDIO_BUFFER_SIZE=1024
```

## Development Workflow

### Starting the development server

```bash
npm run dev
```

This will start a local development server at `http://localhost:3000` with hot reloading enabled.

### Building for production

```bash
npm run build
```

The production-ready files will be available in the `dist` directory.

### Running tests

```bash
# Run all tests
npm test

# Run unit tests only
npm run test:unit

# Run integration tests
npm run test:integration

# Run with coverage report
npm run test:coverage
```

## Project Structure

```
ChordCubes-Enterprise/
├── docs/                 # Documentation
├── src/                  # Source code
│   ├── engine/           # 3D rendering engine
│   ├── audio/            # Audio processing
│   ├── interaction/      # User interaction handling
│   ├── state/            # Application state management
│   ├── utils/            # Utility functions
│   └── assets/           # Static assets
├── tests/                # Test files
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   └── fixtures/         # Test fixtures
├── dist/                 # Build output
├── public/               # Static files
└── config/               # Configuration files
```

## Code Conventions

### JavaScript

- ES6+ syntax
- Module-based architecture
- JSDoc comments for all public methods
- Functional programming approach where appropriate

### WebGL/Three.js

- Optimize for performance
- Use instancing for repeated geometry
- Maintain separation between render logic and business logic

### Audio

- Use WebAudio API with fallbacks
- Handle mobile audio context restrictions
- Implement proper cleanup for audio resources

## Debugging

### WebGL Debugging

For WebGL debugging, enable the following in your browser:

- Chrome: DevTools > Three.js panel
- Firefox: WebGL Shader Editor

### Audio Debugging

For audio debugging:

```javascript
// Enable audio debugging
window.AudioContext = window.AudioContext || window.webkitAudioContext;
const audioContext = new AudioContext({ latencyHint: 'interactive' });
console.log('Sample rate:', audioContext.sampleRate);
console.log('Current time:', audioContext.currentTime);
```

## Performance Considerations

- Use requestAnimationFrame for animations
- Implement proper resource disposal
- Use Web Workers for computationally intensive tasks
- Optimize asset loading and caching

## Browser Compatibility

ChordCubes targets the following browsers:

- Chrome: Latest 2 versions
- Firefox: Latest 2 versions
- Safari: Latest 2 versions
- Edge: Latest 2 versions
- iOS Safari: Latest 2 versions
- Android Chrome: Latest 2 versions

## Troubleshooting

### Common Issues

#### WebGL Not Available

```
Error: WebGL not supported or enabled
```

Solution: Check browser compatibility and GPU drivers. Try enabling hardware acceleration.

#### Audio Context Not Starting

```
DOMException: The AudioContext was not allowed to start
```

Solution: Audio context must be initiated by user interaction. Add a user gesture handler:

```javascript
document.addEventListener('click', () => {
  if (audioContext.state === 'suspended') {
    audioContext.resume();
  }
});
```

## Getting Help

- **Technical issues**: File an issue in the GitHub repository
- **Documentation**: Check the `docs` directory or the wiki
- **Discussion**: Join the developer chat on Discord

## Contributing

Please see the [CONTRIBUTING.md](./CONTRIBUTING.md) file for contribution guidelines.

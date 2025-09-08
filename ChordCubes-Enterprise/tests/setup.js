// Jest setup file
import '@testing-library/jest-dom';

// Mock for AudioContext
window.AudioContext = jest.fn().mockImplementation(() => ({
  createGain: jest.fn().mockReturnValue({
    connect: jest.fn(),
    gain: {
      value: 1,
      setValueAtTime: jest.fn(),
    },
  }),
  createOscillator: jest.fn().mockReturnValue({
    connect: jest.fn(),
    start: jest.fn(),
    stop: jest.fn(),
    frequency: {
      value: 440,
      setValueAtTime: jest.fn(),
    },
  }),
  destination: {},
  currentTime: 0,
  resume: jest.fn().mockImplementation(() => Promise.resolve()),
  suspend: jest.fn(),
  close: jest.fn(),
}));

window.webkitAudioContext = window.AudioContext;

// Mock for WebGL
const mockWebGLRenderingContext = {
  canvas: document.createElement('canvas'),
  drawingBufferWidth: 800,
  drawingBufferHeight: 600,
  getExtension: jest.fn(),
  getShaderPrecisionFormat: jest.fn().mockReturnValue({
    precision: 23,
    rangeMin: 127,
    rangeMax: 127,
  }),
  getParameter: jest.fn(),
  getContext: jest.fn(),
  viewport: jest.fn(),
  clearColor: jest.fn(),
  clear: jest.fn(),
  enable: jest.fn(),
  disable: jest.fn(),
  blendFunc: jest.fn(),
  vertexAttribPointer: jest.fn(),
  enableVertexAttribArray: jest.fn(),
  useProgram: jest.fn(),
  activeTexture: jest.fn(),
  bindTexture: jest.fn(),
  drawArrays: jest.fn(),
  drawElements: jest.fn(),
  createBuffer: jest.fn().mockReturnValue({}),
  bindBuffer: jest.fn(),
  bufferData: jest.fn(),
  createTexture: jest.fn().mockReturnValue({}),
  texImage2D: jest.fn(),
  texParameteri: jest.fn(),
  createShader: jest.fn().mockReturnValue({}),
  shaderSource: jest.fn(),
  compileShader: jest.fn(),
  getShaderParameter: jest.fn().mockReturnValue(true),
  getShaderInfoLog: jest.fn().mockReturnValue(''),
  createProgram: jest.fn().mockReturnValue({}),
  attachShader: jest.fn(),
  linkProgram: jest.fn(),
  getProgramParameter: jest.fn().mockReturnValue(true),
  getProgramInfoLog: jest.fn().mockReturnValue(''),
  getAttribLocation: jest.fn().mockReturnValue(0),
  getUniformLocation: jest.fn().mockReturnValue({}),
  uniform1i: jest.fn(),
  uniform1f: jest.fn(),
  uniform2f: jest.fn(),
  uniform3f: jest.fn(),
  uniform4f: jest.fn(),
  uniformMatrix4fv: jest.fn(),
};

HTMLCanvasElement.prototype.getContext = jest.fn((contextType) => {
  if (contextType === 'webgl' || contextType === 'webgl2' || contextType === 'experimental-webgl') {
    return mockWebGLRenderingContext;
  }
  return null;
});

// Mock for requestAnimationFrame and cancelAnimationFrame
global.requestAnimationFrame = jest.fn((callback) => {
  return setTimeout(() => callback(Date.now()), 0);
});

global.cancelAnimationFrame = jest.fn((id) => {
  clearTimeout(id);
});

// Mock for local storage
const localStorageMock = (() => {
  let store = {};
  return {
    getItem: jest.fn((key) => store[key] || null),
    setItem: jest.fn((key, value) => {
      store[key] = value.toString();
    }),
    removeItem: jest.fn((key) => {
      delete store[key];
    }),
    clear: jest.fn(() => {
      store = {};
    }),
    length: 0,
    key: jest.fn((i) => Object.keys(store)[i] || null),
  };
})();

Object.defineProperty(window, 'localStorage', { value: localStorageMock });

// Mock for navigator
Object.defineProperty(navigator, 'userAgent', {
  value: 'jest-test-environment',
  writable: true,
});

// Console error/warning override to fail tests on unexpected console messages
const originalConsoleError = console.error;
const originalConsoleWarn = console.warn;

console.error = function mockConsoleError(...args) {
  originalConsoleError(...args);
  // Uncomment the line below to make tests fail on console.error
  // throw new Error(`Unexpected console.error(): ${args.join(' ')}`);
};

console.warn = function mockConsoleWarn(...args) {
  originalConsoleWarn(...args);
  // Uncomment the line below to make tests fail on console.warn
  // throw new Error(`Unexpected console.warn(): ${args.join(' ')}`);
};

// Cleanup after each test
afterEach(() => {
  jest.clearAllMocks();
});

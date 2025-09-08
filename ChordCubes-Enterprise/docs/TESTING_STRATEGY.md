# ChordCubes V1.50 Gold - Testing Strategy

## Overview
This document outlines the comprehensive testing strategy for the ChordCubes V1.50 Gold release. The strategy includes unit tests, integration tests, and end-to-end tests to ensure high-quality feature implementation and regression prevention.

## Testing Framework

### Unit Testing Framework
- **Jest**: Primary framework for unit testing JavaScript modules
- **Web Audio Testing Library**: For testing audio-related functionality
- **Three.js Testing Utilities**: For testing 3D rendering components

### Integration Testing Framework
- **Cypress**: For component integration testing
- **WebGL Testing Utilities**: For testing WebGL rendering pipeline

### End-to-End Testing Framework
- **Cypress**: For full application testing
- **BrowserStack**: For cross-browser compatibility testing

## Test Categories

### 1. Unit Tests

#### Core Module Tests
- **State Management**
  - Test state initialization
  - Test state transitions
  - Test state persistence
  - Test state serialization/deserialization

- **Chord Logic**
  - Test chord creation
  - Test interval manipulation
  - Test chord quality modifications
  - Test chord notation generation

- **Audio Processing**
  - Test audio context initialization
  - Test instrument loading
  - Test note generation
  - Test audio parameter adjustments

- **Interaction Logic**
  - Test FSM state transitions
  - Test drag thresholds
  - Test click vs. drag detection
  - Test gesture recognition

#### UI Component Tests
- **Button Handlers**
  - Test reset button functionality
  - Test stop button functionality
  - Test drum controls functionality
  - Test view button functionality

- **Instrument Selectors**
  - Test instrument loading
  - Test instrument switching
  - Test instrument parameter adjustments

- **Chord UI Elements**
  - Test cube face generation
  - Test texture application
  - Test label rendering
  - Test responsive sizing

### 2. Integration Tests

#### UI Integration
- **Keyboard and UI Interaction**
  - Test keyboard shortcuts
  - Test keyboard modifiers
  - Test UI control synchronization

- **WebGL and DOM Integration**
  - Test WebGL canvas initialization
  - Test overlay positioning
  - Test responsive layout

- **Audio and UI Integration**
  - Test audio feedback with UI changes
  - Test UI updates based on audio state

#### Component Integration
- **Chord and Audio Integration**
  - Test chord changes affect audio output
  - Test audio parameters affect chord playback

- **3D Scene and Interaction Integration**
  - Test 3D object interaction
  - Test camera control integration
  - Test raycasting and picking

- **State and UI Integration**
  - Test UI updates based on state changes
  - Test state persistence across UI interactions

### 3. End-to-End Tests

#### User Workflows
- **Basic Chord Manipulation**
  - Test dragging chords from shelf to front row
  - Test rotating chords
  - Test chord progression playback

- **Advanced Feature Usage**
  - Test compound interval creation
  - Test sus chord creation
  - Test forced chord quality

- **Full Application Flow**
  - Test complete chord progression creation
  - Test saving and loading progressions
  - Test integration with external systems

#### Cross-Browser Compatibility
- **Desktop Browsers**
  - Chrome (latest)
  - Firefox (latest)
  - Safari (latest)
  - Edge (latest)

- **Mobile Browsers**
  - iOS Safari
  - Android Chrome
  - Android Firefox

- **Tablet Browsers**
  - iPad Safari
  - Android Chrome/Firefox

## Test Implementation

### 1. UI/UX Enhancement Tests

#### Reset Button Enhancement
```javascript
describe('Reset Button Enhancement', () => {
  beforeEach(() => {
    // Setup test environment
    document.body.innerHTML = `
      <button id="reset-button">Reset</button>
      <input id="bass-toggle" type="checkbox" />
      <input id="melody-toggle" type="checkbox" />
      <input id="chord-toggle" type="checkbox" />
    `;
    
    // Mock audio transport
    window.chordCubesTransport = {
      stopAllAudio: jest.fn()
    };
    
    // Mock reset function
    window.resetScene = jest.fn();
    
    // Initialize reset button enhancement
    enhanceResetButton();
  });
  
  test('should stop all audio on reset', () => {
    // Trigger click event
    document.getElementById('reset-button').click();
    
    // Verify audio stop was called
    expect(window.chordCubesTransport.stopAllAudio).toHaveBeenCalled();
  });
  
  test('should unlock all instruments on reset', () => {
    // Setup initial state
    document.getElementById('bass-toggle').checked = false;
    document.getElementById('melody-toggle').checked = false;
    document.getElementById('chord-toggle').checked = false;
    
    // Trigger click event
    document.getElementById('reset-button').click();
    
    // Verify all toggles are checked
    expect(document.getElementById('bass-toggle').checked).toBe(true);
    expect(document.getElementById('melody-toggle').checked).toBe(true);
    expect(document.getElementById('chord-toggle').checked).toBe(true);
  });
  
  test('should trigger existing reset functionality', () => {
    // Trigger click event
    document.getElementById('reset-button').click();
    
    // Verify reset scene was called
    expect(window.resetScene).toHaveBeenCalled();
  });
});
```

#### Stop Button Implementation
```javascript
describe('Stop Button Implementation', () => {
  beforeEach(() => {
    // Setup test environment
    document.body.innerHTML = `
      <div class="control-button stop-button" id="stop-button">
        <svg width="24" height="24" viewBox="0 0 24 24">
          <rect x="6" y="6" width="12" height="12" fill="#ff3b30" />
        </svg>
        <span>STOP</span>
      </div>
    `;
    
    // Mock audio transport
    window.chordCubesTransport = {
      stopAllAudio: jest.fn()
    };
    
    // Initialize stop button
    implementStopButton();
  });
  
  test('should stop all audio when clicked', () => {
    // Trigger click event
    document.getElementById('stop-button').click();
    
    // Verify audio stop was called
    expect(window.chordCubesTransport.stopAllAudio).toHaveBeenCalled();
  });
  
  test('should provide visual feedback when clicked', () => {
    // Mock timer
    jest.useFakeTimers();
    
    // Trigger click event
    document.getElementById('stop-button').click();
    
    // Verify active class is added
    expect(document.getElementById('stop-button').classList.contains('active')).toBe(true);
    
    // Advance timer
    jest.advanceTimersByTime(200);
    
    // Verify active class is removed
    expect(document.getElementById('stop-button').classList.contains('active')).toBe(false);
    
    // Restore timer
    jest.useRealTimers();
  });
});
```

### 2. Keyboard & MIDI Control Tests

#### Compound Intervals Implementation
```javascript
describe('Compound Intervals Implementation', () => {
  beforeEach(() => {
    // Setup test environment
    window.editingChord = true;
    
    // Mock interval function
    window.addInterval = jest.fn();
    
    // Initialize compound intervals
    implementCompoundIntervals();
  });
  
  test('should add 13th with Option+9', () => {
    // Create key event
    const event = new KeyboardEvent('keydown', {
      key: '9',
      altKey: true
    });
    
    // Dispatch event
    window.dispatchEvent(event);
    
    // Verify interval was added
    expect(window.addInterval).toHaveBeenCalledWith(13);
  });
  
  test('should add 6th with regular 9 key', () => {
    // Create key event
    const event = new KeyboardEvent('keydown', {
      key: '9',
      altKey: false
    });
    
    // Dispatch event
    window.dispatchEvent(event);
    
    // Verify interval was added
    expect(window.addInterval).toHaveBeenCalledWith(6);
  });
  
  test('should not add intervals when not editing chord', () => {
    // Set editing state to false
    window.editingChord = false;
    
    // Create key event
    const event = new KeyboardEvent('keydown', {
      key: '9',
      altKey: true
    });
    
    // Dispatch event
    window.dispatchEvent(event);
    
    // Verify interval was not added
    expect(window.addInterval).not.toHaveBeenCalled();
  });
});
```

#### Force Chord Quality Implementation
```javascript
describe('Force Chord Quality Implementation', () => {
  let currentChord;
  
  beforeEach(() => {
    // Setup test environment
    window.editingChord = true;
    
    // Mock current chord
    currentChord = {
      setInterval: jest.fn(),
      getInterval: jest.fn().mockReturnValue(4), // Default to major third
      updateNotation: jest.fn()
    };
    
    // Mock getCurrentChord function
    window.getCurrentChord = jest.fn().mockReturnValue(currentChord);
    
    // Mock update functions
    window.updateCubeFaceNotation = jest.fn();
    window.updateAudio = jest.fn();
    
    // Initialize force chord quality
    implementForceChordQuality();
  });
  
  test('should force major quality with "m" key', () => {
    // Create key event
    const event = new KeyboardEvent('keydown', {
      key: 'm'
    });
    
    // Dispatch event
    window.dispatchEvent(event);
    
    // Verify third is set to major (4 semitones)
    expect(currentChord.setInterval).toHaveBeenCalledWith(2, 4);
    
    // Verify notation and audio are updated
    expect(window.updateCubeFaceNotation).toHaveBeenCalled();
    expect(window.updateAudio).toHaveBeenCalled();
  });
  
  test('should force minor quality with "n" key', () => {
    // Create key event
    const event = new KeyboardEvent('keydown', {
      key: 'n'
    });
    
    // Dispatch event
    window.dispatchEvent(event);
    
    // Verify third is set to minor (3 semitones)
    expect(currentChord.setInterval).toHaveBeenCalledWith(2, 3);
    
    // Verify notation and audio are updated
    expect(window.updateCubeFaceNotation).toHaveBeenCalled();
    expect(window.updateAudio).toHaveBeenCalled();
  });
  
  test('should force diminished quality with "d" key', () => {
    // Create key event
    const event = new KeyboardEvent('keydown', {
      key: 'd'
    });
    
    // Dispatch event
    window.dispatchEvent(event);
    
    // Verify third is set to minor and fifth is diminished
    expect(currentChord.setInterval).toHaveBeenCalledWith(2, 3);
    expect(currentChord.setInterval).toHaveBeenCalledWith(3, 6);
    
    // Verify notation and audio are updated
    expect(window.updateCubeFaceNotation).toHaveBeenCalled();
    expect(window.updateAudio).toHaveBeenCalled();
  });
});
```

### 3. Integration Tests

#### Audio System Integration
```javascript
describe('Audio System Integration', () => {
  beforeEach(() => {
    // Setup test environment
    cy.visit('/');
    
    // Wait for application to load
    cy.get('#loading-overlay').should('not.be.visible');
  });
  
  it('should play chord when clicked', () => {
    // Spy on audio context
    cy.window().then((win) => {
      cy.spy(win.Tone.context, 'resume').as('resumeContext');
    });
    
    // Click on a chord in the shelf
    cy.get('.shelf-cube').first().click();
    
    // Verify audio context was resumed
    cy.get('@resumeContext').should('have.been.called');
    
    // Verify chord is playing (visual feedback)
    cy.get('.playing-indicator').should('be.visible');
  });
  
  it('should stop all audio when stop button is clicked', () => {
    // Start playing a progression
    cy.get('#play-progression-button').click();
    
    // Wait for playback to start
    cy.get('.playing-indicator').should('be.visible');
    
    // Click stop button
    cy.get('#stop-button').click();
    
    // Verify playback stops
    cy.get('.playing-indicator').should('not.be.visible');
  });
  
  it('should change instrument when dropdown is changed', () => {
    // Select a different instrument
    cy.get('#chord-instrument-select').select('piano');
    
    // Verify instrument change event is fired
    cy.window().then((win) => {
      expect(win.chordCubesTransport.lastInstrumentChange).to.equal('piano');
    });
  });
});
```

#### 3D Rendering Integration
```javascript
describe('3D Rendering Integration', () => {
  beforeEach(() => {
    // Setup test environment
    cy.visit('/');
    
    // Wait for application to load
    cy.get('#loading-overlay').should('not.be.visible');
  });
  
  it('should render cubes with correct textures', () => {
    // Check for WebGL canvas
    cy.get('canvas').should('be.visible');
    
    // Verify cubes are rendered
    cy.window().then((win) => {
      const cubes = win.scene.children.filter(child => child.type === 'Mesh');
      expect(cubes.length).to.be.greaterThan(0);
      
      // Check textures
      const materials = cubes[0].material;
      expect(materials).to.have.length(6); // 6 faces
      
      // Verify materials have textures
      const hasTextures = materials.every(material => material.map !== null);
      expect(hasTextures).to.be.true;
    });
  });
  
  it('should update camera position when view buttons are clicked', () => {
    // Get initial camera position
    let initialPosition;
    cy.window().then((win) => {
      initialPosition = { ...win.camera.position };
    });
    
    // Click melody view button
    cy.get('#melody-view-button').click();
    
    // Verify camera position changed
    cy.window().then((win) => {
      expect(win.camera.position.x).to.not.equal(initialPosition.x);
      expect(win.camera.position.y).to.not.equal(initialPosition.y);
      expect(win.camera.position.z).to.not.equal(initialPosition.z);
    });
    
    // Click back view button
    cy.get('#back-view-button').click();
    
    // Verify camera position changed again
    cy.window().then((win) => {
      expect(win.camera.position.z).to.be.lessThan(0); // Behind the shelf
    });
  });
});
```

### 4. End-to-End Tests

#### Complete User Workflow
```javascript
describe('Complete User Workflow', () => {
  beforeEach(() => {
    // Setup test environment
    cy.visit('/');
    
    // Wait for application to load
    cy.get('#loading-overlay').should('not.be.visible');
  });
  
  it('should create and play a chord progression', () => {
    // Add several chords to the front row
    cy.get('.shelf-cube').eq(0).click(); // I chord
    cy.get('.front-row').children().should('have.length', 1);
    
    cy.get('.shelf-cube').eq(3).click(); // IV chord
    cy.get('.front-row').children().should('have.length', 2);
    
    cy.get('.shelf-cube').eq(4).click(); // V chord
    cy.get('.front-row').children().should('have.length', 3);
    
    cy.get('.shelf-cube').eq(0).click(); // I chord again
    cy.get('.front-row').children().should('have.length', 4);
    
    // Play the progression
    cy.get('#play-progression-button').click();
    
    // Verify playback indicators
    cy.get('.playing-indicator').should('be.visible');
    
    // Wait for progression to complete
    cy.wait(5000); // Assuming each chord plays for ~1 second
    
    // Verify playback stops automatically
    cy.get('.playing-indicator').should('not.be.visible');
  });
  
  it('should use keyboard shortcuts for chord modifications', () => {
    // Add a chord to the front row
    cy.get('.shelf-cube').eq(0).click(); // I chord
    
    // Focus on the chord
    cy.get('.front-row').children().first().click();
    
    // Press 'm' to force major quality
    cy.get('body').type('m');
    
    // Verify chord notation indicates major
    cy.get('.cube-face-label').should('contain', 'maj');
    
    // Press '7' to add 7th
    cy.get('body').type('7');
    
    // Verify chord notation indicates 7th
    cy.get('.cube-face-label').should('contain', '7');
    
    // Press backspace to remove chord
    cy.get('body').type('{backspace}');
    
    // Verify chord is removed
    cy.get('.front-row').children().should('have.length', 0);
  });
});
```

## Automated Testing Setup

### Jest Configuration
```javascript
// jest.config.js
module.exports = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  moduleNameMapper: {
    '\\.(css|less)$': '<rootDir>/__mocks__/styleMock.js',
    '\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$': '<rootDir>/__mocks__/fileMock.js'
  },
  transform: {
    '^.+\\.js$': 'babel-jest'
  },
  collectCoverage: true,
  coverageReporters: ['text', 'lcov'],
  coverageDirectory: 'coverage'
};
```

### Cypress Configuration
```javascript
// cypress.config.js
module.exports = {
  e2e: {
    baseUrl: 'http://localhost:8080',
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
    viewportWidth: 1280,
    viewportHeight: 720,
    video: true,
    screenshotOnRunFailure: true
  }
};
```

### CI Integration
```yaml
# .github/workflows/test.yml
name: Test

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16.x'
      - name: Install dependencies
        run: npm ci
      - name: Run unit tests
        run: npm test
      - name: Run E2E tests
        uses: cypress-io/github-action@v4
        with:
          start: npm start
          wait-on: 'http://localhost:8080'
      - name: Upload coverage
        uses: codecov/codecov-action@v2
```

## Test Coverage Goals

### Unit Tests
- **Core Logic**: 90% coverage
- **UI Components**: 80% coverage
- **Utilities**: 90% coverage

### Integration Tests
- **Key Workflows**: 100% coverage
- **UI Integration**: 80% coverage
- **Audio Integration**: 80% coverage

### End-to-End Tests
- **Critical Paths**: 100% coverage
- **Error Paths**: 80% coverage
- **Cross-browser**: Test on at least 3 major browsers

## Test Execution

### Local Development
```bash
# Run unit tests
npm test

# Run unit tests with coverage
npm test -- --coverage

# Run integration tests
npm run test:integration

# Run E2E tests
npm run test:e2e

# Run all tests
npm run test:all
```

### CI/CD Pipeline
- Run unit tests on every commit
- Run integration tests on pull requests
- Run E2E tests before deployment
- Generate coverage reports
- Enforce minimum coverage thresholds

## Test Reports

### Coverage Report
- Line coverage
- Branch coverage
- Function coverage
- Statement coverage

### Test Results
- Pass/fail status
- Execution time
- Error details for failed tests

### Visual Regression
- Before/after screenshots
- Highlight visual differences

## Continuous Improvement

### Test Metrics
- Test execution time
- Coverage trends
- Pass/fail ratio
- Flaky test identification

### Review Process
- Regular test suite reviews
- Identify test gaps
- Refactor slow or flaky tests
- Update tests for new features

## Appendix

### Mock Objects

#### Audio Context Mock
```javascript
// __mocks__/audioContextMock.js
class AudioContextMock {
  constructor() {
    this.state = 'suspended';
    this.destination = {
      connect: jest.fn()
    };
  }
  
  createGain() {
    return {
      gain: {
        value: 1,
        setValueAtTime: jest.fn(),
        linearRampToValueAtTime: jest.fn(),
        exponentialRampToValueAtTime: jest.fn()
      },
      connect: jest.fn()
    };
  }
  
  createOscillator() {
    return {
      type: 'sine',
      frequency: {
        value: 440,
        setValueAtTime: jest.fn()
      },
      connect: jest.fn(),
      start: jest.fn(),
      stop: jest.fn()
    };
  }
  
  resume() {
    this.state = 'running';
    return Promise.resolve();
  }
  
  suspend() {
    this.state = 'suspended';
    return Promise.resolve();
  }
}

global.AudioContext = AudioContextMock;
global.webkitAudioContext = AudioContextMock;
```

#### Three.js Mock
```javascript
// __mocks__/threeMock.js
class Object3DMock {
  constructor() {
    this.position = { x: 0, y: 0, z: 0 };
    this.rotation = { x: 0, y: 0, z: 0 };
    this.scale = { x: 1, y: 1, z: 1 };
    this.quaternion = { x: 0, y: 0, z: 0, w: 1 };
    this.children = [];
    this.parent = null;
    this.visible = true;
    this.type = 'Object3D';
  }
  
  add(child) {
    this.children.push(child);
    child.parent = this;
  }
  
  remove(child) {
    const index = this.children.indexOf(child);
    if (index !== -1) {
      this.children.splice(index, 1);
      child.parent = null;
    }
  }
  
  lookAt(x, y, z) {
    // Mock implementation
  }
}

class MeshMock extends Object3DMock {
  constructor(geometry, material) {
    super();
    this.geometry = geometry;
    this.material = material;
    this.type = 'Mesh';
  }
}

class WebGLRendererMock {
  constructor(params) {
    this.domElement = document.createElement('canvas');
    this.shadowMap = {
      enabled: false,
      type: 'PCFShadowMap'
    };
  }
  
  setSize(width, height) {
    this.domElement.width = width;
    this.domElement.height = height;
  }
  
  render(scene, camera) {
    // Mock implementation
  }
}

global.THREE = {
  Object3D: Object3DMock,
  Mesh: MeshMock,
  WebGLRenderer: WebGLRendererMock,
  Scene: Object3DMock,
  PerspectiveCamera: Object3DMock,
  BoxGeometry: class {},
  MeshStandardMaterial: class {},
  Vector3: class {
    constructor(x, y, z) {
      this.x = x || 0;
      this.y = y || 0;
      this.z = z || 0;
    }
  }
};
```

### Test Data

#### Chord Test Data
```javascript
// testData/chords.js
const testChords = [
  {
    roman: 'I',
    root: 'C',
    intervals: [0, 4, 7], // Root, major third, fifth
    quality: 'major'
  },
  {
    roman: 'ii',
    root: 'D',
    intervals: [0, 3, 7], // Root, minor third, fifth
    quality: 'minor'
  },
  {
    roman: 'iii',
    root: 'E',
    intervals: [0, 3, 7], // Root, minor third, fifth
    quality: 'minor'
  },
  {
    roman: 'IV',
    root: 'F',
    intervals: [0, 4, 7], // Root, major third, fifth
    quality: 'major'
  },
  {
    roman: 'V',
    root: 'G',
    intervals: [0, 4, 7], // Root, major third, fifth
    quality: 'major'
  },
  {
    roman: 'vi',
    root: 'A',
    intervals: [0, 3, 7], // Root, minor third, fifth
    quality: 'minor'
  },
  {
    roman: 'viiø',
    root: 'B',
    intervals: [0, 3, 6], // Root, minor third, diminished fifth
    quality: 'diminished'
  }
];

module.exports = testChords;
```

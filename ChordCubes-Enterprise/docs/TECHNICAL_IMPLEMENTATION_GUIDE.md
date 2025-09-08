# ChordCubes V1.50 Gold - Technical Implementation Guide

## Overview
This document provides detailed technical specifications for implementing the ChordCubes V1.50 Gold feature enhancements. It serves as a reference for developers working on specific components of the application.

## Core Architecture

### Three.js Rendering Pipeline
The rendering pipeline is based on Three.js with the following key components:
- `WebGLRenderer` with alpha and antialiasing
- Orthographic camera for UI elements
- Perspective camera for 3D scene
- SRGB textures with anisotropy
- Custom shaders for wood grain and lighting

### Audio System Architecture
The audio system utilizes:
- Web Audio API for low-level sound generation
- SoundFont player for instrument synthesis
- Multiple audio layers (chord bed, bass, melody)
- Separate drum machine system with patterns

### State Management
State is managed through:
- `stateStore.js` for persistent application state
- Local component state for UI elements
- WebGL state for 3D scene
- Audio context state for sound generation

## Feature Implementation Details

### 1. Reset Button Enhancement

#### Technical Requirements:
```javascript
// In main.js
function enhanceResetButton() {
  const resetButton = document.getElementById('reset-button');
  
  resetButton.addEventListener('click', () => {
    // 1. Stop all audio playback
    if (window.chordCubesTransport) {
      window.chordCubesTransport.stopAllAudio();
    }
    
    // 2. Unlock all instruments
    document.getElementById('bass-toggle').checked = true;
    document.getElementById('melody-toggle').checked = true;
    document.getElementById('chord-toggle').checked = true;
    
    // 3. Trigger existing reset functionality
    resetScene();
  });
}
```

#### Integration Points:
- Connect to existing reset function in `main.js`
- Update UI state in `index.html`
- Reset audio state in transport bridge

### 2. Stop Button Implementation

#### Technical Requirements:
```html
<!-- In index.html -->
<div class="control-button stop-button" id="stop-button">
  <svg width="24" height="24" viewBox="0 0 24 24">
    <rect x="6" y="6" width="12" height="12" fill="#ff3b30" />
  </svg>
  <span>STOP</span>
</div>
```

```javascript
// In main.js
function implementStopButton() {
  const stopButton = document.getElementById('stop-button');
  
  stopButton.addEventListener('click', () => {
    // Stop all audio playback
    if (window.chordCubesTransport) {
      window.chordCubesTransport.stopAllAudio();
    }
    
    // Visual feedback
    stopButton.classList.add('active');
    setTimeout(() => {
      stopButton.classList.remove('active');
    }, 200);
  });
}
```

#### Integration Points:
- Add button to chord instrument stack in `index.html`
- Implement stop functionality in `main.js`
- Connect to transport bridge for audio control

### 3. Drum Machine Controls Refinement

#### Technical Requirements:
```javascript
// In professional-drum-machine.js
class DrumMachine {
  constructor() {
    this.playing = false;
    this.muted = false;
    // ...existing code
  }
  
  toggleMute() {
    this.muted = !this.muted;
    
    if (this.muted) {
      // Mute all drum tracks without stopping
      this.tracks.forEach(track => {
        track.gainNode.gain.value = 0;
      });
    } else {
      // Unmute all drum tracks
      this.tracks.forEach(track => {
        track.gainNode.gain.value = track.volume;
      });
    }
    
    // Update UI
    document.getElementById('drums-toggle-label').textContent = 
      this.muted ? 'Drums OFF' : 'Drums ON';
    
    return this.muted;
  }
  
  stop() {
    this.playing = false;
    // Stop all scheduled events
    this.tracks.forEach(track => {
      if (track.source) {
        track.source.stop();
        track.source = null;
      }
    });
    
    // Update UI
    document.getElementById('drum-machine-play-icon').classList.remove('active');
  }
}
```

#### Integration Points:
- Update drum machine class in `professional-drum-machine.js`
- Add stop icon to drum machine widget in `index.html`
- Connect to transport bridge for synchronization

### 4. Back View Button Fix

#### Technical Requirements:
```javascript
// In main.js
function fixBackViewButton() {
  const backViewButton = document.getElementById('back-view-button');
  
  backViewButton.addEventListener('click', () => {
    // Position camera behind shelf, looking at shelf face
    camera.position.set(0, 1.5, -8);
    camera.lookAt(0, 0, -4);
    
    // Update controls
    controls.target.set(0, 0, -4);
    controls.update();
    
    // Visual feedback
    backViewButton.classList.add('active');
    document.getElementById('melody-view-button').classList.remove('active');
    document.getElementById('bass-view-button').classList.remove('active');
  });
}
```

#### Integration Points:
- Update camera controls in `main.js`
- Ensure proper target setting for OrbitControls
- Add smooth transition between camera positions

### 5. Chord Movement Animation

#### Technical Requirements:
```javascript
// In tweens.js
function enhanceChordMovement() {
  // Modify existing tween configuration
  const TWEEN_CONFIG = {
    duration: 400,     // Reduced from 600ms
    easing: TWEEN.Easing.Quadratic.Out,
    startDelay: 0,     // No delay, start INSTANTLY
    endEarlyOffset: 50 // Complete movement before new chord arrives
  };
  
  return {
    createMovementTween(object, targetPosition, onComplete) {
      // Immediately start the tween
      const tween = new TWEEN.Tween(object.position)
        .to(targetPosition, TWEEN_CONFIG.duration)
        .easing(TWEEN_CONFIG.easing)
        .onComplete(() => {
          if (onComplete) onComplete();
        });
      
      // Start immediately with no delay
      tween.start();
      return tween;
    }
  };
}
```

#### Integration Points:
- Update tween configuration in `tweens.js`
- Ensure immediate start of animations
- Optimize animation timing to complete before new chord arrival

### 6. Chord Manipulation Responsiveness

#### Technical Requirements:
```javascript
// In interactionFSM.js
class EnhancedInteractionFSM extends InteractionFSM {
  constructor(opts = {}) {
    // Reduce drag threshold for more responsive interactions
    opts.DRAG_START_PX = opts.DRAG_START_PX ?? 4; // Reduced from 8
    opts.CLICK_MAX_PX = opts.CLICK_MAX_PX ?? 3;   // Reduced from 5
    
    super(opts);
    
    // Add weighted movement for front row
    this.weightedMovement = {
      enabled: true,
      factor: 1.2, // Responsiveness factor
      frontRowMultiplier: 1.5 // Increased responsiveness for front row
    };
  }
  
  // Override movement calculation for more responsive front row
  calculateMovement(x, y, isFrontRow = false) {
    if (!this.weightedMovement.enabled) {
      return { x, y };
    }
    
    const dx = x - this.downX;
    const dy = y - this.downY;
    
    // Apply weighting factor
    const factor = isFrontRow ? 
      this.weightedMovement.factor * this.weightedMovement.frontRowMultiplier :
      this.weightedMovement.factor;
    
    return {
      x: this.downX + (dx * factor),
      y: this.downY + (dy * factor)
    };
  }
}
```

#### Integration Points:
- Extend the InteractionFSM class in `interactionFSM.js`
- Update mouse/touch handling in `main.js`
- Add front row detection for enhanced responsiveness

### 7. Cube Face Legibility

#### Technical Requirements:
```javascript
// In textureConfig.js
function enhanceCubeFaceLegibility() {
  // Lighten wood texture
  const woodTexture = {
    color: '#f5e8d0', // Lightened by 50%
    roughness: 0.65,
    metalness: 0.1
  };
  
  // Implement responsive text sizing
  function getResponsiveTextSize(text, maxWidth) {
    const baseSize = 72; // Base font size
    const minSize = 48;  // Minimum font size
    const textLength = text.length;
    
    // Scale font size based on text length
    let fontSize = baseSize;
    if (textLength > 3) {
      fontSize = Math.max(minSize, baseSize - ((textLength - 3) * 8));
    }
    
    return fontSize;
  }
  
  // Ensure text never touches colored borders
  function applyTextPadding(context, text, width, height, borderWidth) {
    const padding = borderWidth * 1.5; // 50% more than border width
    const availableWidth = width - (padding * 2);
    const availableHeight = height - (padding * 2);
    
    // Measure text with current font
    const metrics = context.measureText(text);
    const textWidth = metrics.width;
    const textHeight = metrics.actualBoundingBoxAscent + metrics.actualBoundingBoxDescent;
    
    // Calculate scale factor to fit within available space
    const scaleFactor = Math.min(
      availableWidth / textWidth,
      availableHeight / textHeight
    );
    
    return scaleFactor;
  }
  
  return {
    woodTexture,
    getResponsiveTextSize,
    applyTextPadding
  };
}
```

#### Integration Points:
- Update wood texture properties in `textureConfig.js`
- Implement responsive text sizing for cube faces
- Ensure proper padding between text and borders

## Keyboard & MIDI Control Implementation

### 1. Compound Intervals Implementation

#### Technical Requirements:
```javascript
// In main.js or dedicated keyboard handler
function implementCompoundIntervals() {
  // Key event listener
  window.addEventListener('keydown', (event) => {
    // Check if we're in chord editing mode
    if (!editingChord) return;
    
    // Handle Option key for compound intervals
    if (event.altKey) {
      const key = event.key;
      
      // Map number keys to compound intervals
      switch (key) {
        case '9':
          addInterval(13); // 13th
          break;
        case '7':
          addInterval(11); // 11th
          break;
        case '5': 
          addInterval(9);  // 9th
          break;
        // Add more mappings as needed
      }
    } else {
      // Handle regular intervals (non-compound)
      const key = event.key;
      
      switch (key) {
        case '9':
          addInterval(6); // 6th
          break;
        case '7':
          addInterval(7); // 7th
          break;
        // Add more mappings as needed
      }
    }
  });
}
```

#### Integration Points:
- Implement in main keyboard handler in `main.js`
- Update chord generation in `chords.js`
- Connect to audio system for proper playback

### 2. Force Chord Quality Implementation

#### Technical Requirements:
```javascript
// In main.js or dedicated keyboard handler
function implementForceChordQuality() {
  // Key event listener
  window.addEventListener('keydown', (event) => {
    // Check if we're in chord editing mode
    if (!editingChord) return;
    
    // Force chord quality based on key
    switch (event.key.toLowerCase()) {
      case 'm':
        forceChordQuality('major');
        break;
      case 'n':
        forceChordQuality('minor');
        break;
      case 'd':
        forceChordQuality('diminished');
        break;
    }
  });
  
  function forceChordQuality(quality) {
    const currentChord = getCurrentChord();
    
    // Modify only the 3rd for major/minor
    if (quality === 'major' || quality === 'minor') {
      const third = quality === 'major' ? 4 : 3; // semitones
      currentChord.setInterval(2, third);
    }
    
    // Modify both 3rd and 5th for diminished
    if (quality === 'diminished') {
      currentChord.setInterval(2, 3);  // minor 3rd
      currentChord.setInterval(3, 6);  // diminished 5th
    }
    
    // Update cube face notation
    updateCubeFaceNotation(currentChord);
    
    // Update audio output
    updateAudio(currentChord);
  }
}
```

#### Integration Points:
- Implement in main keyboard handler in `main.js`
- Update chord generation in `chords.js`
- Connect to cube face renderer for notation updates

### 3. Sus Chord Implementation

#### Technical Requirements:
```javascript
// In main.js or dedicated keyboard handler
function implementSusChords() {
  let sus2Active = false;
  let sus4Active = false;
  
  // Key event listeners
  window.addEventListener('keydown', (event) => {
    // Check if we're in chord editing mode
    if (!editingChord) return;
    
    // Handle sus chord keys
    if (event.key === '2') {
      sus2Active = true;
      applySusChord(2);
    } else if (event.key === '4') {
      sus4Active = true;
      applySusChord(4);
    }
  });
  
  window.addEventListener('keyup', (event) => {
    // Reset sus chord state on key release
    if (event.key === '2') {
      sus2Active = false;
      resetChordQuality();
    } else if (event.key === '4') {
      sus4Active = false;
      resetChordQuality();
    }
  });
  
  function applySusChord(type) {
    const currentChord = getCurrentChord();
    
    // Store original 3rd for restoration
    if (!currentChord.originalThird) {
      currentChord.originalThird = currentChord.getInterval(2);
    }
    
    // Remove 3rd from audio output (don't change notation)
    currentChord.setIntervalEnabled(2, false);
    
    // Add sus interval (2nd or 4th)
    if (type === 2) {
      currentChord.addSusInterval(2); // Add 2nd
    } else {
      currentChord.addSusInterval(5); // Add 4th
    }
    
    // Update audio output
    updateAudio(currentChord);
  }
  
  function resetChordQuality() {
    // Only reset if both sus2 and sus4 are inactive
    if (!sus2Active && !sus4Active) {
      const currentChord = getCurrentChord();
      
      // Restore original 3rd
      if (currentChord.originalThird) {
        currentChord.setIntervalEnabled(2, true);
        currentChord.removeSusIntervals();
      }
      
      // Update audio output
      updateAudio(currentChord);
    }
  }
}
```

#### Integration Points:
- Implement in main keyboard handler in `main.js`
- Update chord model to support interval enabling/disabling
- Connect to audio system for proper playback

### 4. Backspace Functionality

#### Technical Requirements:
```javascript
// In main.js or dedicated keyboard handler
function implementBackspaceFunction() {
  // Key event listener
  window.addEventListener('keydown', (event) => {
    // Check for Backspace key
    if (event.key === 'Backspace') {
      removeLastChord();
    }
  });
  
  function removeLastChord() {
    // Get front row lineup
    const lineup = getFrontRowLineup();
    
    // Check if there are any chords to remove
    if (lineup.length === 0) return;
    
    // Get the last chord in the lineup
    const lastChord = lineup[lineup.length - 1];
    
    // Remove the chord from the scene
    removeChordFromScene(lastChord);
    
    // Remove from lineup array
    lineup.pop();
    
    // Update lineup display
    updateLineupDisplay();
    
    // Visual feedback (flash effect)
    createFlashEffect();
  }
}
```

#### Integration Points:
- Implement in main keyboard handler in `main.js`
- Connect to lineup management system
- Add visual feedback for removal action

### 5. Interval Keypress Consistency

#### Technical Requirements:
```javascript
// In main.js or dedicated keyboard handler
function implementIntervalKeypressConsistency() {
  // Key mapping configuration
  const intervalKeyMapping = {
    '1': { interval: 1, name: 'root' },
    '3': { interval: 2, name: '3rd' },
    '5': { interval: 3, name: '5th' },
    '7': { interval: 4, name: '7th', requiresShift: true },
    '9': { interval: 5, name: '6th' },
    '=': { interval: 6, name: '8th' }
  };
  
  // Key event listener
  window.addEventListener('keydown', (event) => {
    // Check if we're in chord editing mode
    if (!editingChord) return;
    
    // Get key and check if it's in our mapping
    const key = event.key;
    const mapping = intervalKeyMapping[key];
    
    if (mapping) {
      // Check if shift is required and pressed
      if (mapping.requiresShift && !event.shiftKey) return;
      
      // Add/toggle the interval
      toggleInterval(mapping.interval);
      
      // Update notation and audio
      updateChordNotation();
      updateAudio();
    }
  });
  
  function toggleInterval(intervalIndex) {
    const currentChord = getCurrentChord();
    const isEnabled = currentChord.isIntervalEnabled(intervalIndex);
    
    // Toggle the interval
    currentChord.setIntervalEnabled(intervalIndex, !isEnabled);
    
    // Visual feedback
    highlightInterval(intervalIndex, !isEnabled);
  }
  
  function updateChordNotation() {
    // Get current chord and its enabled intervals
    const currentChord = getCurrentChord();
    const enabledIntervals = currentChord.getEnabledIntervals();
    
    // Generate notation based on enabled intervals
    let notation = currentChord.getRootNotation();
    
    // Add quality (major/minor/diminished)
    notation += getQualityNotation(currentChord);
    
    // Add extensions (7th, 9th, etc.)
    notation += getExtensionNotation(currentChord);
    
    // Update cube face
    updateCubeFaceText(notation);
  }
}
```

#### Integration Points:
- Implement in main keyboard handler in `main.js`
- Update chord model to support interval enabling/disabling
- Connect to notation generator for proper display

## Testing Procedures

### UI/UX Testing

#### Reset Button Enhancement
- Test reset button while audio is playing
- Verify all instruments are unlocked after reset
- Confirm playback stops completely

#### Stop Button Implementation
- Test stop button during progression playback
- Verify visual feedback on click
- Confirm all audio layers stop immediately

#### Drum Machine Controls
- Test mute functionality without stopping playback
- Verify "Drums OFF" label updates correctly
- Test stop icon functionality in drum machine widget

#### Back View Button
- Test camera positioning after button press
- Verify camera is behind shelf looking at shelf face
- Confirm smooth transition between views

#### Chord Movement Animation
- Test immediate movement start on new chord addition
- Verify animation completes before new chord arrival
- Confirm smooth animation with no stuttering

#### Chord Manipulation Responsiveness
- Test sensitivity of chord movement in front row
- Verify small mouse movements produce appropriate changes
- Compare responsiveness to previous version

#### Cube Face Legibility
- Verify lighter wood texture improves contrast
- Test text sizing with various chord notations
- Confirm text never touches colored borders

### Keyboard & MIDI Testing

#### Compound Intervals
- Test Shift+number combinations for compound intervals
- Verify Option key works for compound intervals
- Confirm proper notation for compound intervals

#### Force Chord Quality
- Test 'm' key for Major quality
- Test 'n' key for miNor quality
- Test 'd' key for Diminished quality
- Verify proper notation updates
- Confirm audio output matches forced quality

#### Sus Chord Implementation
- Test key 2 for sus2 chords
- Test key 4 for sus4 chords
- Verify elimination of 3rd in audio output
- Confirm proper notation

#### Backspace Functionality
- Test Backspace key to remove last chord
- Verify visual feedback on removal
- Confirm lineup updates correctly

#### Interval Keypress Consistency
- Test Shift for diatonic 7th
- Verify "=" key for 8th interval
- Test all interval keypresses
- Confirm proper notation updates

## Deployment Checklist

### Pre-Deployment
- Run all automated tests
- Verify all feature enhancements
- Check performance benchmarks
- Update documentation

### Deployment
- Back up current production version
- Deploy to staging environment
- Perform smoke tests
- Deploy to production environment

### Post-Deployment
- Monitor error logs
- Check user feedback
- Verify analytics
- Schedule follow-up review

## Appendix

### Key Binding Reference
```
// Interval Control
1 - Root
3 - 3rd
5 - 5th
7 - Diatonic 7th
Shift+7 - Major 7th
9 - 6th
Shift+9 - 13th
= - 8th

// Chord Quality Control
m - Force Major quality
n - Force miNor quality
d - Force Diminished quality

// Sus Chord Control
2 - Sus2 chord (hold)
4 - Sus4 chord (hold)

// Navigation
Backspace - Remove last chord
```

### Performance Optimization Tips
- Use object pooling for frequently created objects
- Implement frustum culling for off-screen objects
- Use instanced rendering for similar objects
- Optimize texture sizes and formats
- Implement LOD (Level of Detail) for complex objects
- Use Web Workers for heavy computations

### Browser Compatibility Notes
- Safari: May require prefixing for Web Audio API
- Firefox: Check for WebGL2 support
- Mobile: Touch events instead of mouse events
- iOS: Audio context requires user gesture

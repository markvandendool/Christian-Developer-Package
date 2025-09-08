# ChordCubes V1.50 Gold - Feature Enhancement Backlog

## UI/UX Enhancements

### High Priority
1. ✅ **Reset Button Enhancement**
   - Modify reset button to also unlock all instruments (melody, bass, chords)
   - Add stop playback functionality to reset button

2. ✅ **Stop Button Addition**
   - Add a red STOP button below the "Play Progression" in the chord instrument stack
   - Add a red stop icon next to the play icon in the DRUM MACHINE widget title

3. ⚠️ **Fix Cube Face Legibility**
   - Lighten the wood texture by 50% to improve text contrast
   - Implement responsive text sizing to ensure text stays within colored borders
   - Comment out diminished chord manipulation until responsive text sizing is implemented
   
4. ⚠️ **Front Row Chord Animation**
   - Front row chords must INSTANTLY start moving when a new chord is added
   - Complete movement before new chord flies in to front row
   - Reduce "heaviness" of chord cube handling when changing sequence

5. ⚠️ **Back View Camera Position**
   - Fix back view button to correctly position camera behind the shelf, looking at the shelf

### Medium Priority
6. ✅ **Default Instruments Update**
   - Set default instruments to Cello, Piano and Violin
   - Update dropdowns to reflect the default instruments

7. ✅ **Free Play Options**
   - Add toggle between "last chord cutoff" and "fixed sustain"
   - Add text field for sustain time (default: 3 seconds)
   - Allow chords to overlap when toggled

8. ⚠️ **Staves Implementation**
   - Comment out 3D staves and implement 2D staves
   - Position camera to view staves clearly
   - Ensure play button does not trigger staves appearance
   - Position show staves buttons underneath bass/melody/back view buttons

## Keyboard & Control Enhancements

### High Priority
1. ⚠️ **Compound Intervals Fix**
   - Fix compound intervals: shift + number should insert compound interval
   - Example: shift + 9 adds 13th, 9 alone adds 6th
   - Move compound intervals to option key instead of shift

2. ⚠️ **Voice Range Limits**
   - Implement hard limits for each voice (melody, bass)
   - Prevent voice leading from causing extreme ranges during looped progressions

3. ⚠️ **Keyboard Shortcut Framework**
   - Create system for keyboard shortcuts based on Novaxe MIDI controller shortcuts service
   - Implement framework for sending MIDI messages across devices/channels
   - Import Novaxe MIDI system and adapt for ThreeJS

4. ⚠️ **Fix Chord Quality Forcing**
   - Implement holding m, n, or d to force Major, miNor, or Diminished quality
   - Update cube notation to reflect forced changes (e.g., IV to iv, update scale degrees)
   - Ensure only specific intervals change (3rd for minor, 3rd and 5th for diminished)
   - Example: When IV chord with b7th is created, update 3 diamond to b3 diamond

### Medium Priority
5. ✅ **Backspace Functionality**
   - Make backspace remove the last added chord from the front line

6. ✅ **Seventh Chord Handling**
   - Return to using shift for diatonic 7th, remove from option key
   - Ensure cube face text reflects these changes
   - Fix shift/opt click method for 7ths to update notation display properly
   - Get note information downstream from button press

7. ✅ **Add Octave Control**
   - Add "8" functionality for intervals (using "=" key)
   - Current major 7 uses "-" key

8. ✅ **Sus Chord Implementation**
   - When keypress 2 or 4 is held, eliminate 3rd of chord in audio
   - Implement as sus2 and sus4 chords without explicit "sus" labeling

9. ⚠️ **Non-Chord Tones for Melodies/Bass**
   - Dedicate numpad to bass control
   - Map numpad keys 1-7 to scale degrees
   - Use numpad "." as flat modifier
   - Use "enter" as sharp modifier
   - Example: G/C would be G chord + numpad 4

## Bug Fixes

### Critical Priority
1. 🔴 **Instrument Tuning Issue**
   - Fix tuning problems with cello instrument (50 cents flat on Root position chord 3)
   - Investigate frequency manipulation in note generation

2. 🔴 **Persistent Cube Face Variations**
   - Fix cube faces staying frozen in last variation
   - Example: when key 5 is held and ii chord with (4) is added, the 4 stays on shelf
   - Use keystroke debugger to identify root cause

### High Priority
3. ⚠️ **Drums OFF Functionality**
   - Fix Drums OFF to mute drum loops/presets without stopping playback

## Integration & Future Development

### Low Priority
1. 📝 **Angular Integration**
   - Plan integration into Novaxe Angular app with tabbing system
   - Use same system as Magic 18, with cubes icon tab
   - Connect to Novaxe brain functionality

2. 📝 **Font Implementation**
   - Use fontdec13 for cube faces

## Notes
- Tasks marked ✅ are ready for implementation
- Tasks marked ⚠️ require further clarification or technical investigation
- Tasks marked 🔴 are critical bugs needing immediate attention
- Tasks marked 📝 are for future planning

# ChordCubes V1.50 Gold - Feature Enhancement Backlog

## UI/UX Enhancements

### High Priority
1. ⚠️ **Reset Button Enhancement**
   - Modify reset button to also unlock all instruments (melody, bass, chords)
   - Add stop playback functionality to reset action

2. ⚠️ **Stop Button Implementation**
   - Add a red STOP button below the central "Play Progression" in the chord instrument stack
   - Ensure visual consistency with existing UI elements

3. ⚠️ **Drum Machine Controls Refinement**
   - Modify "Drums OFF" to mute drum loops/presets without stopping playback
   - Add a red stop icon next to the play icon in the DRUM MACHINE widget title

4. ⚠️ **Back View Button Fix**
   - Correct camera positioning when back view button is pressed
   - Ensure camera moves behind the shelf, looking at the shelf face

5. ⚠️ **Chord Movement Animation**
   - Front row chords must INSTANTLY start moving when new chord is added
   - Complete movement before new chord arrives in the front row

6. ⚠️ **Chord Manipulation Responsiveness**
   - Improve "weight" of chord cube handling in front row
   - Adjust sensitivity for small mouse movements to produce appropriate cube position changes

7. ⚠️ **Cube Face Legibility**
   - Lighten wood texture by 50% to improve text contrast
   - Implement responsive text sizing for cube faces (text should never touch colored borders)

### Medium Priority
8. ⚠️ **Staves Implementation**
   - Comment out 3D staves temporarily
   - Implement 2D staves with clear camera positioning
   - Ensure play button does not trigger staves appearance
   - Position show staves buttons underneath bass/melody/back view buttons

9. ⚠️ **Free Play User Options**
   - Add toggle between last chord cutoff and fixed sustain
   - Add text field for sustain time (default: 3 seconds)

10. ⚠️ **Default Instrument Configuration**
    - Set default instruments to Cello, Piano and Violin
    - Ensure dropdown menus correctly reflect default selections

## Keyboard & MIDI Control

### High Priority
11. ⚠️ **Compound Intervals Implementation**
    - Fix Shift+number combination for compound intervals
    - Shift+9 should add 13th, 9 alone adds 6th
    - Move compound intervals functionality to Option key instead of Shift

12. ⚠️ **Force Chord Quality Implementation**
    - Implement keypress modifiers for chord quality:
      - 'm' key: Force Major quality
      - 'n' key: Force miNor quality
      - 'd' key: Force Diminished quality
    - Ensure cube face notation updates to reflect forced quality
    - Only modify the 3rd for Major/Minor, both 3rd and 5th for Diminished
    - Do not alter 7th or other tones (those should be controlled by interval keypresses)

13. ⚠️ **Sus Chord Implementation**
    - When keypress 2 or 4 is held, eliminate the 3rd of the chord in audio output
    - Create sus2 and sus4 chords without explicitly showing "sus" in notation

14. ⚠️ **Backspace Functionality**
    - Implement Backspace key to remove the last added chord from the front line

15. ⚠️ **Interval Keypress Consistency**
    - Return to using Shift for diatonic 7th (remove from Option key)
    - Ensure cube face text reflects these changes correctly
    - Add support for "8" interval using "=" key
    - Fix dynamic/diatonic interval notation to properly display in chord notation

### Medium Priority
16. ⚠️ **Keyboard Shortcuts Framework**
    - Implement Novaxe MIDI controller shortcuts service
    - Create framework for keyboard shortcuts based on existing MIDI system
    - Support MIDI message transmission across multiple devices/channels

17. ⚠️ **Non-Chord Tones Implementation**
    - Implement numpad for bass note control using scale degrees (1-7)
    - Use numpad "." as flat modifier and "Enter" as sharp modifier
    - Example: G/C would be G chord + numpad 4

## Bug Fixes

### Critical
18. ⚠️ **Voice Leading Limits**
    - Set hard limits for each voice to prevent extreme ranges during loop playback
    - Apply constraints to melody and bass voice leading algorithms

19. ⚠️ **Instrument Tuning Fix**
    - Resolve extreme tuning problem with cello instrument (particularly noticeable on Root position chord 3)
    - Investigate frequency manipulation of notes
    - Verify tuning across all instruments

20. ⚠️ **Persistent Cube Face State**
    - Fix cube faces remaining frozen in last variation state
    - Ensure cube faces return to default state after temporary modifications

## Integration & Architecture

### Medium Priority
21. ⚠️ **Novaxe Angular Integration**
    - Prepare for reintegration into Novaxe Angular app
    - Implement tabbing system similar to Magic 18
    - Add Cubes icon to bottom tab bar
    - Design integration with Novaxe brain

22. ⚠️ **Font Implementation**
    - Implement fontdec13 for cube faces
    - Ensure proper loading and rendering of custom font

## Legend
- ✅ Completed
- 🔄 In Progress
- ⚠️ Not Started
- ❌ Blocked

# ChordCubes 6.0 V1.50 - Production Ready
## Professional 3D Chord Visualization System

[![Version](https://img.shields.io/badge/version-6.0.1.50-blue.svg)](https://github.com/markvandendool/Christian-Developer-Package)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Live Demo](https://img.shields.io/badge/demo-live-brightgreen.svg)](https://millionsongmind.com/cubes)

**ChordCubes** is a professional-grade 3D interactive chord visualization system that provides real-time harmonic analysis and educational tools for musicians, composers, and music theorists.

## 🚀 Live Demo

Visit the live application: **[millionsongmind.com/cubes](https://millionsongmind.com/cubes)**

## 📋 Overview
Professional 3D interactive chord visualization system for production deployment

## 🔧 Deployment Details
- **Live URL**: https://millionsongmind.com/cubes/
- **Version**: ChordCubes 6.0 V1.50 (Restored from V1.49 backup)
- **Build Date**: September 5, 2025
- **Technology**: Pure WebGL + JavaScript with advanced 3D engine
- **Core Engine**: 10,685 lines of optimized JavaScript
- **Total Assets**: 36+ files including fonts, configs, and modules

## ✨ Features
### 🎵 Core Functionality
- **3D WebGL Rendering**: Professional-grade 3D chord visualization
- **Real-time Analysis**: Live harmonic analysis and feedback  
- **Interactive Interface**: Physics-based drag system with touch/mouse support
- **Professional Audio**: Integrated drum machine and multi-instrument tools

### 🎹 Musical Intelligence
- **Chord Progression Engine**: Advanced chord analysis algorithms
- **3D Musical Staves**: Interactive staff notation in 3D space  
- **Roman Numeral Analysis**: Comprehensive harmonic analysis
- **Voice Leading**: Advanced voice leading algorithms
- **Shelf Mapping**: REST/MOTION/TENSION zone analysis

### 🎨 Professional Experience
- **Custom Typography**: Novaxe Diamond Font with ligature support
- **Advanced Lighting**: Professional stage lighting system
- **Save/Load**: Custom arrangement persistence
- **Multi-instrument**: Chord/bass/melody audio layers
- **SoundFont Integration**: High-quality audio synthesis

## 🛠️ Technical Requirements
- Modern browser with WebGL support (Chrome 90+, Firefox 88+, Safari 14+)
- Web Audio API support
- ES6 modules support  
- Internet connection for CDN resources (Three.js, fonts)
- Minimum 4GB RAM recommended for complex scenes

## File Structure
```
cubes/
├── index.html              # Production-optimized entry point
├── main.js                 # Core 3D engine (3,436 lines)
├── chords.js              # Chord theory and musical logic
├── styles.css             # Production styles
├── raycastRouter.js       # Interaction handling
├── shelfMapService.js     # Shelf system
├── interactionFSM.js      # State management
├── diagnosticsOverlay.js  # Debug tools
├── stateStore.js         # Data persistence
├── textureConfig.js      # Visual configuration
├── tweens.js             # Animation system
├── engine/               # Core engine components
├── integration/          # External integrations
└── assets/               # Static resources
```

## CDN Dependencies
- Three.js v0.160.0 (https://unpkg.com/three@0.160.0/)
- SoundFont Player v0.15.7 (https://unpkg.com/soundfont-player@0.15.7/)
- Tone.js v14.8.49 (https://unpkg.com/tone@14.8.49/)
- Tonal.js v4.12.1 (https://cdn.jsdelivr.net/npm/@tonaljs/tonal@4.12.1/)
- Troika Three Text v0.49.0 (https://unpkg.com/troika-three-text@0.49.0/)

## Performance Optimizations
- Preloaded critical resources
- Lazy loading of audio instruments
- Efficient Three.js scene management
- Optimized animation loops
- Memory management and cleanup
- CDN failover handling

## SEO & Social Media
- Complete Open Graph meta tags
- Twitter Card integration
- Canonical URL setup
- Structured meta descriptions
- Performance monitoring
- Error tracking

## Deployment Steps
1. Upload entire `cubes/` directory to web server
2. Ensure `millionsonmind.com/cubes/` points to `index.html`
3. Verify HTTPS is enabled
4. Test WebGL and Web Audio functionality
5. Validate all CDN resources load correctly
6. Test on multiple browsers and devices

## Production Features
- Loading overlay with spinner
- Error handling and fallbacks
- Performance monitoring
- Production logging
- Cache-busting with version parameters
- Responsive design for all screen sizes

## Browser Support
- Chrome 80+
- Firefox 75+
- Safari 13+
- Edge 80+
- Mobile browsers with WebGL support

## Monitoring
The application includes built-in performance monitoring and error tracking. Check browser console for:
- Load time metrics
- WebGL support detection
- CDN resource loading status
- Error reports

## Maintenance
- Monitor CDN uptime for dependencies
- Update Three.js version periodically
- Review browser compatibility
- Update audio instrument libraries as needed
- Regular backup of user-generated shelf maps

## Contact
Million Song Mind Development Team
millionsonmind.com

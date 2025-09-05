# Christian Developer Package - PHOENIX HUB

## 🌟 CURRENT STATUS
- **Phoenix Hub**: ✅ Online at https://millionsongmind.com/
- **ChordCubes**: ✅ Working at https://millionsongmind.com/cubes/
- **Million Song Mind**: ✅ Working at https://millionsongmind.com/MSM/
- **Harmonic Oracle**: 🔧 Integration in progress
- **Melody Lab**: 🔧 Integration in progress

## SETUP TIME: 30-45 minutes

### Prerequisites
- Node.js 18+ 
- npm or pnpm
- Git
- Working terminal (if issues, see TROUBLESHOOTING.md)

### Installation Steps

1. **Clone and Navigate**
```bash
git clone https://github.com/markvandendool/Christian-Developer-Package.git
cd Christian-Developer-Package
```

2. **Install Dependencies**
```bash
npm install
cd apps/chordcubes && npm install
cd ../million-song-mind && npm install
cd ../..
```

3. **Start Development Servers**
```bash
# Start all apps
npm run dev:all

# Or start individually
npm run dev:cubes  # Port 5173
npm run dev:msm    # Port 5174
```

## KNOWN ISSUES
1. MSM production deployment blocked by Vercel Security
2. Terminal may have issues with pyenv interference
3. Some asset paths still reference /MSM/

## TROUBLESHOOTING
See [TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md) for common issues.
curl -I https://millionsongmind.com
curl -I https://millionsongmind.com/cubes/
curl -I https://millionsongmind.com/MSM/

# Verify bundle sizes match documentation
curl -s https://millionsongmind.com/cubes/main.js | wc -c    # Should be 480140
```

## Step 2: Start Local Development Server
```bash
# Navigate to this package
cd CHRISTIAN_DEVELOPER_PACKAGE

# Start ChordCubes (port 8000)
python -m http.server 8000

# In separate terminal, start MSM (port 5173)
cd apps/million-song-mind
npm run dev

# Open in browser:
# http://localhost:8000/apps/chordcubes/     (3D visualization)
# http://localhost:5173/MSM/                (React analysis)
```

## Step 3: Test Core Functionality
- [ ] **ChordCubes:** Click and drag 3D cubes, test audio
- [ ] **MSM:** Upload a CSV file, verify HUV processing
- [ ] **Systems:** Verify both applications load without errors

**🎉 You're ready to develop! Total setup time: 5 minutes.**

---

# 📁 PACKAGE STRUCTURE (Industry Standard)

```
CHRISTIAN_DEVELOPER_PACKAGE/
├── 📖 README.md                    # Start here (this file)
├── 🏃 QUICK_START_GUIDE.md        # Step-by-step setup
├── 📦 package.json                # Dependencies & scripts
│
├── 🎮 apps/                       # Complete applications
│   ├── chordcubes/               # ChordCubes 6.0 source + docs
│   │   ├── main.js               # Core application (10,686 lines)
│   │   ├── index.html            # Application entry point
│   │   ├── README.md             # ChordCubes documentation
│   │   └── tech-spec.md          # Technical specification
│   │
│   └── million-song-mind/        # MSM React platform
│       ├── src/                  # React source (20,786 lines)
│       ├── dist/                 # Built application
│       ├── README.md             # MSM documentation
│       └── architecture.md       # Component architecture
│
├── 📚 docs/                       # Master documentation
│   ├── ARCHITECTURE.md           # Complete system architecture
│   ├── SYSTEMS_MAP.md            # Visual systems overview
│   ├── HUV_VECTORS.md            # HUV vector complete spec
│   ├── DEVELOPMENT_GUIDE.md      # How to develop & contribute
│   ├── DEPLOYMENT.md             # Production deployment
│   ├── TROUBLESHOOTING.md        # Debug & problem solving
│   └── API_REFERENCE.md          # Complete API documentation
│
├── 🛠️ tools/                      # Development utilities
│   ├── setup.sh                 # Automated setup script
│   ├── health-check.sh          # Verify all systems working
│   ├── build-all.sh             # Build all applications
│   ├── deploy.sh                # Deploy to production
│   └── test-runner.sh           # Run comprehensive tests
│
├── 📊 data/                       # Sample data & schemas
│   ├── sample-data3-files/       # Test CSV files with HUV vectors
│   ├── schemas/                  # Data format specifications
│   ├── test-fixtures/           # Unit test data
│   └── examples/                # Usage examples
│
└── 🧪 tests/                      # Complete test suite
    ├── integration-tests.sh      # End-to-end system tests
    ├── unit-tests/              # Individual component tests
    └── production-verification.sh # Production system checks
```

---

# 🎼 APPLICATION DEEP DIVE

## ChordCubes 6.0 V1.50 - 3D Visualization Engine
**Location:** `apps/chordcubes/`
**URL:** http://localhost:8000/apps/chordcubes/

```javascript
Key Components:
├── main.js (10,686 lines)          # Core application logic
├── OrchestralAudioEngine           # WebAudioFont + Tone.js fallback  
├── InteractionFSM                  # Finite state machine
├── RaycastRouter                   # 3D object picking
├── ShelfMapService                 # 3D positioning system
└── DiagnosticsOverlay              # Performance monitoring

Technical Specs:
- THREE.js r158 with WebGL rendering
- Dual rest zones: front row (y=0, z=0) + shelf origins
- Magnetic physics with neighbor displacement
- Voice leading constraints: Melody C4-C6, Chord C3-C5, Bass C1-G3
- High-resolution label rendering with web fonts
```

## Million Song Mind React - Analysis Platform  
**Location:** `apps/million-song-mind/`
**URL:** http://localhost:5173/MSM/

```typescript
Key Components:
├── src/pages/MillionSongMind.tsx   # Main app (1,666 lines)
├── src/components/ (57 components) # UI component library
├── src/utils/ (21 modules)         # Business logic (2,891 lines)
├── HUV Vector Processor            # 27-slot Roman analysis
├── Data3 CSV Parser                # Multi-format detection
└── Braid Geometry System           # xi/ine calibration

Technical Specs:
- React 18.3.1 + TypeScript 5.1.6
- Vite 5.4.19 build system with SWC
- Shadcn/ui + Radix UI components
- React Three Fiber for 3D integration
- 1.57MB production bundle (optimized)
- Runs on port 5173 with base path /MSM/
```

---

# 🔧 DEVELOPER WORKFLOWS

## Daily Development Commands
```bash
# Start ChordCubes
cd CHRISTIAN_DEVELOPER_PACKAGE
python -m http.server 8000

# Start MSM (separate terminal)
cd apps/million-song-mind
npm run dev

# Health check all systems
./tools/health-check.sh

# Build everything for production
./tools/build-all.sh

# Run comprehensive tests
./tools/test-runner.sh
```

## Making Changes
```bash
# 1. Make your changes to source code
# 2. Test locally
# ChordCubes: http://localhost:8000/apps/chordcubes/
# MSM: http://localhost:5173/MSM/

# 3. Verify production systems still work
curl -I https://millionsongmind.com

# 4. Build and deploy (when ready)
./tools/deploy.sh
```

## Debugging Workflows
```bash
# Check production bundle integrity
curl -s https://millionsongmind.com/cubes/main.js | wc -c

# Enable debug mode in browser
localStorage.setItem('novaxe-debug', 'true');

# Monitor system health
./tools/health-check.sh --verbose
```

---

# 🆘 HELP & TROUBLESHOOTING

## Common Issues & Solutions

**"Applications won't load"**
```bash
# Check Node.js version (needs 18+)
node --version

# Kill conflicting processes
pkill -f "python.*http.server"
pkill -f "node.*vite"

# Restart development servers
python -m http.server 8000  # For ChordCubes
cd apps/million-song-mind && npm run dev  # For MSM
```

**"CORS errors"**  
```bash
# Use proper local server (not file://)
python -m http.server 8000
# Access via http://localhost:8000/
```

**"Bundle size doesn't match"**
```bash
# Production verification
curl -s https://millionsongmind.com/cubes/main.js | wc -c    # Should be 480140
curl -s https://millionsongmind.com/MSM/ | grep main        # Should find React bundle
```

**"CSV upload fails in MSM"**
- Check CSV format matches Data3 specification
- Verify HUV vectors use correct `total,root,first,second,third` format
- Check sample files in `data/sample-data3-files/`

## Getting Help
1. **Check Documentation:** All answers in `docs/` folder
2. **Run Health Check:** `./tools/health-check.sh`
3. **Verify Production:** Compare against https://millionsongmind.com
4. **Check Sample Data:** Use files in `data/` for testing

---

# 🏆 SUCCESS CRITERIA

## ✅ Developer Package Setup Complete When:
- [ ] Both applications start without errors
- [ ] Production systems verified and accessible
- [ ] Local development servers functional (ports 8000 and 5173)
- [ ] Can upload and process CSV in MSM
- [ ] ChordCubes 3D responds to mouse interaction
- [ ] Health check script passes all tests

## 🚀 Developer Mastery Achieved When:
- [ ] Can confidently modify any application
- [ ] Understands all system integration points
- [ ] Can debug and resolve issues independently
- [ ] Can safely deploy changes to production
- [ ] Can onboard and guide other developers
- [ ] Contributes to architecture improvements

---

# 📞 SUPPORT & CONTACT

**Production Systems:** https://millionsongmind.com (verified operational)  
**Repository:** `Novaxe-SEB-Million-Song-Mind` (branch: `Christian/Mark`)  
**Package Version:** Industry Standard Developer Onboarding v1.1

**Emergency Contacts:**
- System down: Check Vercel dashboard
- Build issues: Verify Node.js 18+ and dependencies
- Data issues: Check HUV vector format in `docs/HUV_VECTORS.md`

---

**🎉 Welcome to the NOVAXE ecosystem, Christian!**

*This package contains everything you need to become a world-class developer on the most advanced musical intelligence platform ever created. Follow the learning progression, use the tools provided, and you'll be productive in no time.*

**Let's build the future of musical intelligence together! 🚀🎼**

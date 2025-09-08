#!/bin/bash
# ChordCubes Enterprise - First Sprint Setup Script
# Creates initial project infrastructure for agile development workflow

# Configuration
PROJECT_ROOT="/Users/markvandendool/Christian-Developer-Package/ChordCubes-Enterprise"
LOG_DIR="${PROJECT_ROOT}/logs"
JIRA_PROJECT_KEY="CUBE"
SPRINT_NUMBER="1"
SPRINT_START=$(date +"%Y-%m-%d")
SPRINT_END=$(date -v+14d +"%Y-%m-%d")

# Make sure we're in the project root
cd "$PROJECT_ROOT" || exit 1

# Create sprint directory structure
mkdir -p "${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/tasks"
mkdir -p "${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/documentation"
mkdir -p "${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/testing"

# Create sprint configuration file
cat > "${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/sprint-config.json" << EOL
{
  "sprintNumber": ${SPRINT_NUMBER},
  "sprintName": "Project Infrastructure Setup",
  "startDate": "${SPRINT_START}",
  "endDate": "${SPRINT_END}",
  "tasks": [
    {"id": "${JIRA_PROJECT_KEY}-001", "title": "Create project backlog in Jira", "assignee": "TBD", "storyPoints": 5},
    {"id": "${JIRA_PROJECT_KEY}-002", "title": "Implement automated testing framework", "assignee": "TBD", "storyPoints": 8},
    {"id": "${JIRA_PROJECT_KEY}-003", "title": "Set up CI/CD pipeline", "assignee": "TBD", "storyPoints": 5}
  ],
  "sprintGoal": "Establish core infrastructure for agile development workflow"
}
EOL

# Create task template for Jira import
cat > "${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/tasks/jira-tasks.csv" << EOL
Summary,Description,Issue Type,Priority,Story Points,Epic Link
Create project backlog in Jira,Set up Jira project for ChordCubes V1.50 Gold with proper epics user stories and tasks. Integrate with GitHub for automated issue tracking.,Task,High,5,CUBE-000
Implement automated testing framework,Create Jest/Cypress testing suite for ChordCubes with unit integration and E2E tests. Focus on core features: 3D rendering keyboard input and HUD components.,Task,High,8,CUBE-000
Set up CI/CD pipeline,Configure GitHub Actions workflow for automated testing building and deployment to staging and production environments. Include security scanning and code quality checks.,Task,High,5,CUBE-000
EOL

# Create sprint planning document
cat > "${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/documentation/SPRINT_PLANNING.md" << EOL
# Sprint ${SPRINT_NUMBER} Planning Document

**Sprint Goal**: Establish core infrastructure for agile development workflow
**Sprint Duration**: 2 weeks
**Start Date**: ${SPRINT_START}
**End Date**: ${SPRINT_END}

## Sprint Backlog

| Task ID | Title | Description | Story Points | Assignee |
|---------|-------|-------------|--------------|----------|
| ${JIRA_PROJECT_KEY}-001 | Create project backlog in Jira | Set up Jira project for ChordCubes V1.50 Gold with proper epics, user stories, and tasks. Integrate with GitHub for automated issue tracking. | 5 | TBD |
| ${JIRA_PROJECT_KEY}-002 | Implement automated testing framework | Create Jest/Cypress testing suite for ChordCubes with unit, integration and E2E tests. Focus on core features: 3D rendering, keyboard input, and HUD components. | 8 | TBD |
| ${JIRA_PROJECT_KEY}-003 | Set up CI/CD pipeline | Configure GitHub Actions workflow for automated testing, building, and deployment to staging and production environments. Include security scanning and code quality checks. | 5 | TBD |

## Sprint Capacity

- Team capacity: TBD
- Available story points: 18
- Velocity (estimated): TBD

## Dependencies

- GitHub repository access
- Jira project setup
- Developer environment setup

## Risks

- Developer onboarding may delay sprint start
- Integration with existing code may present unexpected challenges

## Success Criteria

- Jira project fully configured with GitHub integration
- Initial automated tests running in CI/CD pipeline
- GitHub Actions workflow deploying to staging environment
EOL

# Create initial testing structure
mkdir -p "${PROJECT_ROOT}/development/tests/unit"
mkdir -p "${PROJECT_ROOT}/development/tests/integration"
mkdir -p "${PROJECT_ROOT}/development/tests/e2e"

# Create basic test configuration
cat > "${PROJECT_ROOT}/development/tests/jest.config.js" << EOL
module.exports = {
  roots: ['<rootDir>'],
  testEnvironment: 'jsdom',
  testMatch: [
    '**/tests/unit/**/*.test.js',
    '**/tests/integration/**/*.test.js'
  ],
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/integration/**',
    '!**/node_modules/**',
  ],
  coverageThreshold: {
    global: {
      statements: 80,
      branches: 70,
      functions: 80,
      lines: 80,
    },
  },
  coverageReporters: ['text', 'html'],
  moduleFileExtensions: ['js', 'json'],
};
EOL

# Create sample unit test
cat > "${PROJECT_ROOT}/development/tests/unit/sample.test.js" << EOL
describe('ChordCubes Core Functionality', () => {
  test('placeholder test to verify Jest setup', () => {
    expect(1 + 1).toBe(2);
  });
});
EOL

# Create GitHub workflow template
mkdir -p "${PROJECT_ROOT}/.github/workflows"
cat > "${PROJECT_ROOT}/.github/workflows/ci-cd.yml" << EOL
name: ChordCubes CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16.x'
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm test

  build:
    name: Build
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16.x'
      - name: Install dependencies
        run: npm ci
      - name: Build
        run: npm run build
      - name: Archive build artifacts
        uses: actions/upload-artifact@v2
        with:
          name: build
          path: build

  deploy-staging:
    name: Deploy to Staging
    needs: build
    if: github.event_name == 'push' && github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Download build artifacts
        uses: actions/download-artifact@v2
        with:
          name: build
          path: build
      - name: Deploy to staging
        run: echo "Deploying to staging environment"
        # Add actual deployment steps here

  deploy-production:
    name: Deploy to Production
    needs: build
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Download build artifacts
        uses: actions/download-artifact@v2
        with:
          name: build
          path: build
      - name: Deploy to production
        run: echo "Deploying to production environment"
        # Add actual deployment steps here
EOL

echo "✅ Sprint 1 setup completed successfully!"
echo "📁 Sprint directory: ${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}"
echo "📋 Planning document: ${PROJECT_ROOT}/sprints/sprint-${SPRINT_NUMBER}/documentation/SPRINT_PLANNING.md"
echo "⚙️ GitHub workflow template: ${PROJECT_ROOT}/.github/workflows/ci-cd.yml"
echo "🧪 Test configuration: ${PROJECT_ROOT}/development/tests/jest.config.js"
echo "🚀 Ready to begin Sprint ${SPRINT_NUMBER}!"

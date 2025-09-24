# GitHub Pages Branch (gh-pages) Explanation

## What is the gh-pages branch?

The `gh-pages` branch is a special branch used by GitHub Pages to host static web content. In this Flutter project, it serves as the deployment target for compiled Flutter web applications.

## How it works

### 1. Automatic Deployment Workflow
The repository contains a GitHub Actions workflow (`.github/workflows/deploy.yml`) that:
- Triggers on every push to any branch (`branches: [ '**' ]`)
- Sets up Flutter 3.29.3
- Builds the Flutter web application
- Deploys the compiled web assets to the `gh-pages` branch

### 2. Branch-specific Deployments
The workflow creates branch-specific deployments:
- Each branch gets its own subdirectory in the gh-pages branch
- The build is configured with a base href matching the branch name: `--base-href="/dry_living_mock_wall_unit/${GITHUB_REF##*/}/"`
- The compiled assets are placed in `out/${BRANCH_NAME}/` before deployment

### 3. Live URLs
The deployed applications are accessible via GitHub Pages URLs:
- Main branch: https://hangstrap.github.io/dry_living_mock_wall_unit/main/
- Feature branches: https://hangstrap.github.io/dry_living_mock_wall_unit/{BRANCH_NAME}/

## Current Deployments

As referenced in the README.md, the following live deployments are available:
- **Main branch**: https://hangstrap.github.io/dry_living_mock_wall_unit/main/
- **Simple home page**: https://hangstrap.github.io/dry_living_mock_wall_unit/20250813-simple-home-page/
- **Works like v4.4**: https://hangstrap.github.io/dry_living_mock_wall_unit/20250809-works-like-v4.4/

## Branch Structure

The gh-pages branch contains:
- `.nojekyll` file to disable Jekyll processing
- Subdirectories for each deployed branch containing:
  - `index.html` - Main HTML file with proper base href
  - `main.dart.js` - Compiled Dart code
  - `assets/` - Flutter assets
  - `canvaskit/` - Flutter's CanvasKit renderer files
  - `icons/` - Application icons
  - Other Flutter web runtime files

## Technical Details

- **Flutter Version**: 3.29.3
- **Base Href**: Dynamically set to `/dry_living_mock_wall_unit/{branch_name}/`
- **Deployment Tool**: peaceiris/actions-gh-pages@v3
- **Build Command**: `flutter build web`
- **GitHub Pages Source**: gh-pages branch (automatically configured)

## Benefits

1. **Preview Deployments**: Every branch gets its own live preview URL
2. **Easy Testing**: Stakeholders can test features by visiting branch-specific URLs
3. **No Manual Deployment**: Fully automated via GitHub Actions
4. **Version History**: Each deployment creates a commit in gh-pages with the source commit SHA

This setup enables continuous deployment and easy preview of Flutter web applications for different branches and features.
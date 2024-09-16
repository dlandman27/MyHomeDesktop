# Install Git
winget install --id Git.Git -e --source winget

# Install Node.js (includes npm)
winget install --id OpenJS.NodeJS -e --source winget

# Verify the installation of Git and Node.js
git --version
node --version
npm --version

winget install --id Python.Python.3 -e --source winget

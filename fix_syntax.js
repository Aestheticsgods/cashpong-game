// Quick fix for syntax error - remove orphaned code after line 1181
const fs = require('fs');

let content = fs.readFileSync('script-li-khask-tchuf.js', 'utf8');

// Find the end of the forfeit function and remove orphaned code
const lines = content.split('\n');
let fixedLines = [];
let inOrphanedSection = false;

for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    
    // Check if we hit the orphaned code section
    if (line.includes('console.log("� [IMMEDIATE-FORFEIT] Opponent disconnected! Calling claimVictoryByForfeit immediately...");')) {
        inOrphanedSection = true;
        continue; // Skip this line
    }
    
    // Check if we reach the next proper section
    if (inOrphanedSection && line.includes('socket.on("event", (data) => {')) {
        inOrphanedSection = false;
        // Add back the proper comment and continue
        fixedLines.push('  // Maintenant on utilise seulement le système roomCreated → roomInvitation avec contrat smart contract');
        fixedLines.push('');
    }
    
    // Skip lines in orphaned section
    if (inOrphanedSection) {
        continue;
    }
    
    fixedLines.push(line);
}

fs.writeFileSync('script-li-khask-tchuf.js', fixedLines.join('\n'));
console.log('✅ Syntax errors fixed!');

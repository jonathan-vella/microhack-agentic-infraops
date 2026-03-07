# Facilitator Materials

> **For microhack coaches and facilitators only.**

| File                                           | Purpose                                              |
| ---------------------------------------------- | ---------------------------------------------------- |
| [facilitator-guide.md](facilitator-guide.md)   | Detailed schedule, curveball script, troubleshooting |
| [scoring-rubric.md](scoring-rubric.md)         | WAF-aligned scoring criteria (105+25 pts)            |
| [solution-reference.md](solution-reference.md) | Expected outputs, Bicep patterns, commands           |

## Quick Reference

### Scoring Commands

```powershell
# Score individual team
.\scripts\microhack\Score-Team.ps1 -TeamName "freshconnect" -ShowcaseScore 8

# Score all teams
Get-ChildItem .\agent-output -Directory | ForEach-Object {
    .\scripts\microhack\Score-Team.ps1 -TeamName $_.Name -SkipAzureCheck -ShowcaseScore 0
}

# Display leaderboard
.\scripts\microhack\Get-Leaderboard.ps1
```

### Curveball Timing

⚡ **12:45** — Announce the multi-region DR requirement (see [facilitator-guide.md](facilitator-guide.md) for script)

### Emergency Contacts

| Issue        | Action                                       |
| ------------ | -------------------------------------------- |
| Copilot down | Use template files, extend time              |
| Azure issues | Check status.azure.com, try secondary region |
| Team stuck   | Direct help, skip design artifacts if needed |

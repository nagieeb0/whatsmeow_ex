module govec

go 1.25.0

require go.mau.fi/whatsmeow v0.0.0

// run.sh rewrites this to the absolute path of ../../whatsmeow-main.
replace go.mau.fi/whatsmeow => ../../whatsmeow-main

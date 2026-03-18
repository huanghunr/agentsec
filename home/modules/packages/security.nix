{
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      # Recon / scanning
      nmap
      rustscan
      naabu
      ffuf
      feroxbuster
      gobuster
      nuclei
      nuclei-templates
      sqlmap
      tcpdump
      tshark
      termshark
      mitmproxy
      proxychains
      tor
      torsocks
    ]
    ++ [
      # DevSecOps / detection
      semgrep
      gitleaks
      trivy
      syft
      grype
      yara
      sslscan
      testssl
      ssh-audit
    ]
    ++ [
      # Reverse engineering
      radare2
      apktool
      ghidra
    ]
    ++ [
      # Forensics
      volatility3
      exiftool
      foremost
    ]
    ++ [
      # Password auditing
      hashcat
      john
      medusa
    ]
    ++ [
      # Web security proxy/scanner (headless-capable)
      zap
    ];
}

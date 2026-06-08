{
  pkgs ? import <nixpkgs> { },
  extraPkgs ? [ ],
}:

with pkgs;
let
  # Use Python 3.12 to resolve the Sphinx version conflict
  aeonPython = python312.withPackages (ps: with ps; [
    requests
    python-dotenv
    pydantic
    fastapi
    uvicorn
    pandas
    numpy
    beautifulsoup4
    lxml
  ]);
in
mkShell {
  name = "aeon-777-forensic-env";
  
  buildInputs = [
    # Core Utilities
    aeonPython
    git
    gh
    ffmpeg
    sqlite
    postgresql
    rclone
    jq
    yq-go
    tmate
    
    # AI CLI Engines (Standard Packages)
    aider-chat
  ] ++ extraPkgs;

  shellHook = ''
    export AEON_777_VERSION="2.0.1"
    export PS1="\[\033[1;32m\][AEON-777-NIX]\[\033[0m\] \w \$ "
    
    echo "===================================================="
    echo "   AEON-777 SUPRA-FORENSIC ENVIRONMENT v2.0.1       "
    echo "===================================================="
    echo " [+] Python: $(python --version)"
    echo " [+] Aider: $(aider --version 2>/dev/null || echo 'Ready')"
    echo " [+] Memory Gateway: http://localhost:8089"
    echo "===================================================="
    
    # Optional: If fabric isn't in nixpkgs, you can install via pip inside this shell:
    # pip install fabric-ai
  '';
}

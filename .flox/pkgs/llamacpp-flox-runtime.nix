{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "llamacpp-flox-runtime";
  version = "0.1.0";

  src = ../../scripts;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    for script in llamacpp-serve llamacpp-preflight llamacpp-resolve-model; do
      install -m 0755 "$script" "$out/bin/$script"
    done

    mkdir -p $out/share/llamacpp-flox-runtime
    cat > "$out/share/llamacpp-flox-runtime/llamacpp-flox-runtime-$version" <<'MARKER'
    Initial release of llamacpp-flox-runtime scripts.
    - llamacpp-serve: model env loading and validated llama-server execution
    - llamacpp-preflight: port reclaim, GPU health check, downstream exec
    - llamacpp-resolve-model: multi-source GGUF model provisioning (local, hf-cache, r2, hf-hub)
    MARKER
  '';

  meta = with lib; {
    description = "Runtime scripts for llama.cpp model serving with Flox";
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}

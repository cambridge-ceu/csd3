#!/usr/bin/env bash

module load ceuadmin/ollama
ollama serve &
OLLAMA_PID=$!
sleep 10
if [ -z "$1" ]; then
    INPUT_FILE="Llama-4-Maverick-17B-128E-Instruct.gguf"
    OUTPUT_MODEL="llama4maverick"
else
    INPUT_FILE="$1"
    OUTPUT_MODEL="$2"
fi
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    kill $OLLAMA_PID
    exit 1
fi
echo "FROM ./$INPUT_FILE" | ollama create "$OUTPUT_MODEL" -f -
ollama run "$OUTPUT_MODEL"
kill $OLLAMA_PID

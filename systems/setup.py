import os
import numpy as np
import matplotlib.pyplot as plt
from wordcloud import WordCloud
from collections import Counter
import random

# Set seeds for reproducibility
random.seed(1234321)
np.random.seed(1234321)

# Set CEUADMIN path from env variable or fallback
CEUADMIN = os.getenv('CEUADMIN', os.path.expanduser('~/cambridge-ceu/csd3'))

# Excluded directories/files
EXCLUDE = {"lib", "misc", "sources", "generic.png", "genetics.png"}

def read_list_file(filename):
    """Read lines from a file into a list."""
    try:
        with open(filename, 'r') as f:
            words = [line.strip() for line in f if line.strip()]
        print(f"Read {len(words)} words from {filename}")
        return words
    except FileNotFoundError:
        print(f"{filename} not found.")
        return []

def generate_word_frequencies(words):
    """
    Generate word frequencies with Poisson noise (lambda=3).
    Unlike NLP pipelines, this keeps all terms including hyphens and numbers.
    """
    if not words:
        return {}

    word_counts = Counter([w.strip().lower() for w in words if w.strip()])
    sorted_words = sorted(word_counts.items(), key=lambda x: x[1], reverse=True)
    counts = np.array([count for _, count in sorted_words])
    poisson_noise = np.random.poisson(lam=3, size=len(counts))
    freqs = counts + poisson_noise

    freq_dict = {
        word: freq for (word, _), freq in zip(sorted_words, freqs) if freq > 0
    }
    return freq_dict

def generate_wordcloud(freq_dict, output_png):
    """Generate and save a word cloud image."""
    if not freq_dict:
        print(f"No words to generate word cloud for {output_png}")
        return

    wc = WordCloud(
        width=1000,
        height=1000,
        background_color='white',
        max_words=200,
        min_font_size=10,
        random_state=1234321,
        colormap='Dark2',
        prefer_horizontal=0.65
    ).generate_from_frequencies(freq_dict)

    plt.figure(figsize=(10, 10))
    plt.imshow(wc, interpolation='bilinear')
    plt.axis('off')
    plt.tight_layout(pad=0)
    plt.savefig(output_png, dpi=300)
    plt.close()
    print(f"Saved word cloud to {output_png}")

def main():
    # Process generic.lst
    generic = read_list_file("generic.lst")
    freq_generic = generate_word_frequencies(generic)
    generate_wordcloud(freq_generic, "generic.png")

    # Process genetics.lst
    genetics = read_list_file("genetics.lst")
    freq_genetics = generate_word_frequencies(genetics)
    generate_wordcloud(freq_genetics, "genetics.png")

    # Remove the lst files (as in R script)
    for f in ["generic.lst", "genetics.lst"]:
        try:
            os.remove(f)
        except FileNotFoundError:
            pass

    # Process CEUADMIN directory
    try:
        modules = [
            d for d in os.listdir(CEUADMIN)
            if os.path.isdir(os.path.join(CEUADMIN, d)) and d not in EXCLUDE
        ]
    except FileNotFoundError:
        print(f"CEUADMIN directory not found at {CEUADMIN}")
        modules = []

    print(f"modules ({len(modules)}): {modules[:10]}{'...' if len(modules) > 10 else ''}")
    freq_modules = generate_word_frequencies(modules)
    generate_wordcloud(freq_modules, "ceuadmin.png")

if __name__ == "__main__":
    main()

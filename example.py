#!/usr/bin/env python3
"""
Simple grep-like utility to search for a word in a text file and print matching lines.
Usage: python example.py <filepath> <search_word>
"""

import sys  # Import the system module for accessing command-line arguments and exit functions.


def grep_file(filepath, search_word):
    """
    Search for a word in a file and print all matching lines.

    Args:
        filepath (str): Path to the text file
        search_word (str): Word to search for
    """
    try:
        # Open the file in read mode with UTF-8 encoding.
        with open(filepath, 'r', encoding='utf-8') as file:
            line_number = 0  # Track line numbers for output.
            found_count = 0  # Track how many matches were found.

            # Iterate through each line in the file.
            for line in file:
                line_number += 1  # Increment the line counter.

                # Compare lowercased values for case-insensitive matching.
                if search_word.lower() in line.lower():
                    print(f"{line_number}: {line.rstrip()}")  # Print the matching line.
                    found_count += 1  # Increment match counter.

            # If no matches were found, let the user know.
            if found_count == 0:
                print(f"No matches found for '{search_word}'")
    except FileNotFoundError:
        # Handle missing file error gracefully.
        print(f"Error: File '{filepath}' not found.")
        sys.exit(1)
    except Exception as e:
        # Handle all other exceptions and report the error.
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    # Only execute this block when the script is run directly.

    # If the user provided exactly two arguments, use them.
    if len(sys.argv) == 3:
        file_path = sys.argv[1]  # First argument is the file path.
        search_term = sys.argv[2]  # Second argument is the search word.
    elif len(sys.argv) == 1:
        # If no arguments were provided, use default values.
        file_path = "sample.txt"
        search_term = "linux"
    else:
        # If the wrong number of arguments were provided, show usage instructions.
        print("Usage: python example.py <filepath> <search_word>")
        print("Example: python example.py test_file.txt linux")
        sys.exit(1)

    # Show what is being searched before running the function.
    print(f"Searching for '{search_term}' in '{file_path}':\n")
    grep_file(file_path, search_term)  # Execute the search function.

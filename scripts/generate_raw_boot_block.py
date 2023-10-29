import sys

MAXIMUM_INPUT_SIZE = 446
INTERMEDIATE_SIZE = 510
OUTPUT_SIZE = 512

def main(argv):
    
    if len(argv) < 2:
        print("Usage: python this_script.py <filename>")
        sys.exit(1)


    file_name = argv[1]

    try:
        with open(file_name, 'rb') as file: file_data = file.read(OUTPUT_SIZE)
    except Exception as exception:
        print(f"Error reading file: {exception}")
        sys.exit(1)


    if len(file_data) > MAXIMUM_INPUT_SIZE:
        print(f"File too large: {len(file_data)} bytes (max {MAXIMUM_INPUT_SIZE})")
        sys.exit(1)

    print(f"Size file is {len(file_data)} bytes (max {MAXIMUM_INPUT_SIZE})")


    file_data += b'\0' * (INTERMEDIATE_SIZE - len(file_data))
    file_data += b'\x55\xAA'

    try:
        with open(file_name, 'wb') as file: file.write(file_data)
    except Exception as exception:
        print(f"Error writing to file: {exception}")
        sys.exit(1)    


if __name__ == "__main__":
    main(sys.argv)

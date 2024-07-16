import hashlib

def generate_password(plaintext, service='', length=16):
    # Define the alphabet including lowercase, uppercase, and special chars
    alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+"

    # Generate hash
    hash_input = plaintext + service
    raw_hexdigest = hashlib.sha256(hash_input.encode()).hexdigest()

    # Convert hash to integer
    num = int(raw_hexdigest, 16)

    # Generate password
    num_chars = len(alphabet)
    chars = []

    while len(chars) < length:
        num, idx = divmod(num, num_chars)
        chars.append(alphabet[idx])

    return ''.join(chars)

if __name__ == "__main__":
    plaintext = input("Enter your password: ")
    service = input("Enter service (default is empty): ")
    password_length = input("Enter password length (default is 16): ")

    password = generate_password(
        plaintext,
        service=service or '',
        length=int(password_length) if password_length else 16,
    )

    print(f"Generated password: {password}")

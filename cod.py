import os
import subprocess
import time

LABEL_FOLDER = "labels"  # Folder where PDFs are stored

def print_label(barcode):
    pdf_path = os.path.join(LABEL_FOLDER, f"{barcode}.pdf")
    if os.path.exists(pdf_path):
        print(f"Printing label for: {barcode}")
        try:
            # Windows
            if os.name == 'nt':
                os.startfile(pdf_path, "print")
            # macOS/Linux
            else:
                subprocess.run(["lp", pdf_path])
        except Exception as e:
            print("Error printing:", e)
    else:
        print(f"No label found for: {barcode}")

def main():
    print("Ready to scan barcodes...")
    while True:
        barcode = input("Scan: ").strip()
        if barcode:
            print_label(barcode)

if __name__ == "__main__":
    main()
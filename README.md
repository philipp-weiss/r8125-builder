# r8125-builder

⚡️ Build the Realtek r8125 kernel module in a clean, reproducible Podman container and extract the compiled `r8125.ko` without installing build tools or kernel headers on your host.

This repository uses a minimal Debian container to install only the required headers and DKMS packages, and extracts the module for your target kernel version. Configuration is fully driven by an `.env` file.

---

## 🚀 Why Use This

- 🔧 Avoid installing build tools or kernel headers on your host
- 💯 Reproducible builds for any compatible kernel version
- 📁 Configuration-driven via environment file
- 🧼 Clean output: only the compiled module is copied to your host

---

## 📦 Requirements

- Podman installed (or Docker as a drop-in replacement)
- Internet access to fetch the headers and driver packages
- A valid `.env` file specifying:
  - `HEADERS`: URL to a `.deb` package for your kernel headers
  - `R8125`: URL to the Realtek r8125 DKMS `.deb` package
  - `KERNEL_VERSION`: Directory name of your target kernel (e.g., `6.14.8-2-bpo12-pve`)

---

## 🧪 Provided Example

Included env file for Proxmox VE 9.0:

```bash
# pve_9.0.env
REPO=http://download.proxmox.com/debian/pve/dists/bookworm/pve-no-subscription/binary-amd64/
HEADERS=${REPO}proxmox-headers-6.14.8-2-bpo12-pve_6.14.8-2~bpo12+1_amd64.deb
R8125=${REPO}r8125-dkms_9.013.02-1~bpo12+1_all.deb
KERNEL_VERSION=6.14.8-2-bpo12-pve
```

---

## 🛠️ Usage

```bash
git clone https://github.com/philipp-weiss/r8125-builder.git
cd r8125-builder

# Option 1: Use provided env file
./build_r8125.sh pve_9.0.env

# Option 2: Create your own
cp pve_9.0.env .env
# Edit values to match your system
./build_r8125.sh
```

Once complete, you'll find the compiled module in:

```bash
output/r8125.ko
```

---

## 📂 Installing the Module on Host

```bash
sudo mkdir -p /lib/modules/$(uname -r)/updates/dkms
sudo cp output/r8125.ko /lib/modules/$(uname -r)/updates/dkms/
sudo depmod -a
sudo modprobe r8125
```

Make sure the destination path matches your host kernel. If it doesn't, rebuild with a matching KERNEL_VERSION.

---

## 📄 License

This project is licensed under the MIT License.

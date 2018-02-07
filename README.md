# brother-scan

This tool is alternative to the brscan-skey with automatic document feeder support and compressed PDF output.

## Requirements

### Script

```
sudo apt install python3-venv
```

### Scan

```
sudo apt install sane-utils
```
Note: `scanimage` need to be configure to be able to scan

### Scan ADF (optionnal)

```
sudo apt install sane
```

## Installation

```
git clone git@github.com:neomilium/brother-scan.git
cd brother-scan
python3 -mvenv .
./bin/pip install -r requirements.txt
```

## Configuration

Edit `brother-scan.yaml`

## Run

```
./bin/python main.py
```

## Uselinks

* https://www.mcbsys.com/blog/2014/11/register-pc-on-brother-scanner/
* https://github.com/jmesmon/brother2/blob/master/PROTO

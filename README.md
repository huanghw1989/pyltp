# How-to-use
```
# Build Example
docker build -t pyltp-example -f example.Dockerfile .

# Run Example
docker run --rm -it pyltp-example python -c "import pyltp; print(pyltp.__file__)"
```
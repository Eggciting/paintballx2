def main():
    path = "Eggciting/paintballx2/assets/lib/info.json"
    info = FILE.open(path)
    use = JSON.parse(info)
    print(use.info.code)

main();
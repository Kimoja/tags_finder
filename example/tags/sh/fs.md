<gtags shell bash fs>

<tags file write push>

 ## Write a line at the end of a file
```bash
echo "text" >> mon_fichier.text
```

</tags>

<tags dir create mkdir>

 ## Create one or more folders, without error if existing (-p)
```bash
mkdir -p mon_fichier
```

</tags>

<tags dir file move>

 ## Move a file/folder
```bash
mv -f ancien_nom.txt nouveau_dossier/nouveau_nom.txt
```

</tags>

<tags exec executable chmod>

 ## Making a script executable
```shell 
chmod +x MON_FICHIER
```

</tags>

<tags search ligne line regexp>

 ## Search by regexp in a file
```bash
sed -nE '/^([0-9]{3}-|\\([0-9]{3}\\) )[0-9]{3}-[0-9]{3}\n?/p' file.txt
```

</tags>

<tags symlink symbolic link>

 ## Create a sym link
```bash
ln -s source/path destination/path
```

</tags>

</gtags>
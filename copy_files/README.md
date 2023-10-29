# copy_files

## Introduction

This tool performs a string search of filenames and copies the matched files.
Files here also refer to folders.

## Usage

### Command

```plaintxt
> .\main.ps1 -jsonPath .\config.json
```

All values for `destFolder`, `searchFolder`, `depth`, and `searchString`, described below, must be set in the config file or in the arguments.
This command will copy files whose filenames contain `searchString` to `destFolder`.
The file search is performed under the folder specified by `searchFolder`.
The depth of folders to be included in the search is specified by `depth`.

### Arguments

| Argument | Required | Default | Explanation |
|-|:-:|-|-|
| `-jsonPath <path>` | x | - | A path of JSON config file |
| `-destFolder <path>` | x | `".\out"` | A path of destination folder |
| `-searchFolder <path>` | x | - | A path of folder to search for files |
| `-depth <depth>` | x | `1` | A depth of search in folder specified by `-searchFolder` |
| `-searchString <str>` | x | - | A string to search. |

### Config

```json
{
    "destFolder": <path>,
    "searchFolder": <path>,
    "depth": <depth>,
    "searchString": <str>
}
```

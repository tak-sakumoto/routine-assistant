# extract_str_from_email

## Introduction

This tool searches emails in Microsoft Outlook mail folders for regular expression patterns and extracts strings from the subject and body of matching emails.

## Usage

### Command

```plaintxt
> .\main.ps1 -jsonPath '.\config.json' -outDirPath '.\out' -startTime "<date-time>" -endTime "<date-time>"
```

This command performs a string search on the subject and body of emails in the Outlook folder.
Search results are output in JSON file format under the folder specified in `-outDirPath`.
The search is based on the regular expression pattern described in the config file below.
You can set the start (`-startTime`) and end (`-endTime`) of the received date and time to narrow the search.

### Arguments

| Argument | Required | Default | Explanation |
|-|:-:|-|-|
| `-jsonPath <path>` | o | - | A path of JSON config file |
| `-outDirPath <path>` | x | `".\out"` | A path of destination folder |
| `-startTime <date-time>` | x | `""`| A string of the start of the received date and time (yyyy/MM/dd HH:mm:ss) |
| `-endTime <date-time>` | x | `""` | A string of the end of the received date and time (yyyy/MM/dd HH:mm:ss) |

### Config

```json
{
    "pattern": [
        {
            "subject": <subject-pettern-1>,
            "body": <body-pettern-1>
        },
        {
            "subject": <subject-pettern-2>,
            "body": <body-pettern-2>
        },
        ...
    ]
}

```

The config file contains the respective regular expression patterns used to search the subject and body of the mail.
When a string is captured using the parentheses `()`, the string is extracted and output to a file.
If no capture is done, the string is not extracted and `null` is output to the file.

# Resume Template

This package establishes a simple and easy-to-use LaTeX template for resume.

## Getting Started

### Dependencies

- LaTex: The compilation is based on both XeLaTex and LaTeXmk, please install TeX in advance.
- Python3: One needs to use Python3 to generate necessary `tex` files. To install the dependencies, please use

    ```shell
    conda env create -f environment.yml
    conda activate resume_xia
    ```

### Updating Data

All data (*e.g.*, personal information, education, publication, internship) is separately recorded in `yml` format under [raw_data](raw_data). Please follow the following instructions, which provides a detailed explanations.

#### [info.yml](raw_data/info.yml)

```yml
info:
    name: Name in English
    name*: Name in Chinese
    school: School in English, omit if use `company`
    school*: School in Chinese, omit if use `company*`
    school-url: School website
    department: Department in English
    department*: Department in Chinese
    department-url: Department website
    phone: Phone number
    email: Email
    homepage: Homepage, omit if delete
    googlescholar: Google Scholar page, omit if delete
    linkedin: LinkedIn page, omit if delete
    company: Company in English, omit and use `school` if delete
    company*: Company in Chinese, omit and use `school*` if delete
    company-url: Company website
```

#### [education.yml](raw_data/education.yml)

```yml
education:
    # First education.
    - edu1:
        edu-school: School in English
        edu-school*: School in Chinese
        edu-location: School location in English
        edu-location*: School location in Chinese
        edu-intro: Brief intro in English, e.g., GPA, advisor, period
        edu-intro*: Brief intro in Chinese
        edu-detail: Detailed information in English, e.g., courses
        edu-detail*: Detailed information in Chinese

    # Second education.
    - edu2:
        edu-school: School in English
        edu-school*: School in Chinese
        edu-location: School location in English
        edu-location*: School location in Chinese
        edu-intro: Brief intro in English, e.g., GPA, advisor, period
        edu-intro*: Brief intro in Chinese
        edu-detail: Detailed information in English, e.g., courses
        edu-detail*: Detailed information in Chinese
```

#### [publication.md](raw_data/education.md) and [publication](raw_data/publication)

**WARNING: Current version DOES NOT support publication in Chinese.**

One needs to first write `yml` file for each publication under [publication](raw_data/publication), then summarize in the [publication.md](raw_data/education.md).

For each `yml` file, current version only supports **UP TO 10** authors. One can set `author-contrib-x` to `equal` for equal contribution, and `corresponding` for corresponding author.

```yml
paper_abbr:
    pub-title: Title
    pub-location: Conference name or journal name
    pub-status: set `under` for under review, otherwise delete or set to `none`
    pub-author-a: First author
    pub-contrib-a: equal
    pub-author-b: Second author
    pub-contrib-b: equal
    pub-author-c: Third author
    pub-author-d: Fourth author
    pub-contrib-d: corresponding
```

For [publication.md](raw_data/education.md), one needs to record publications as below, in which commented lines will be ignored. Here, `paper_abbr` is designed to figure out each paper easily and will not be in the resume.

```markdown
# Selected Publications

- [paper_abbr1](publication/paper_abbr1.yml)
- [paper_abbr2](publication/paper_abbr2.yml)
<!-- - [paper_abbr3](publication/paper_abbr3.yml) -->
```

#### [internship.yml](raw_data/internship.yml)

```yml
internship:
    - intern1:
        intern: Intern company in English
        intern*: Intern company in Chinese
        intern-type: Intern type in English
        intern-type*: Intern type in Chinese
        intern-time: Intern period
    - intern2:
        intern: Intern company in English
        intern*: Intern company in Chinese
        intern-type: Intern type in English
        intern-type*: Intern type in Chinese
        intern-time: Intern period
```

### Compilation Instructions

It is recommanded to compile the package through **Makefile**, by simply executing

```shell
make [{data|data-chinese|resume|rebuild|rebuild-chinese|clean|cleandata|cleanall}]
```

- `make data` generates necessary `tex` files in English;
- `make data-chinese` generates necessary `tex` files in Chinese;
- `make resume` generates `resume.pdf` WITHOUT generating or updating all data, use only after `make data` or `make data-chinese`;
- `make rebuild` first generates necessary `tex` files in English **BY FORCE**, and then generates `resume.pdf`;
- `make rebuild-chinese` first generates necessary `tex` files in Chinese **BY FORCE**, and then generates `resume.pdf`;
- `make clean` deletes only intermediate temporary files by LaTeX;
- `make cleandata` deletes all intermediate temporary files by LaTeX, together with data files under [data](data/);
- `make cleanall` deletes all intermediate temporary files, together with `resume.pdf` and data files under [data](data/).

## Customization

Please feel free to add more items to your resume (*e.g.*, experiences, academic services). In order to do so, one needs to implement the **render commands** in [resume_xia.cls](resume_xia.cls), the **data parser** in [generate_data.py](generate_data.py), and the **data structures** in [data.yml](data.yml). It is recommended to follow the implementation of the existing functionality.

## TODOList

- [x] Improve the Chinese version.
- [x] Update the font.
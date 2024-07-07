# python3.8
# Generate all tex file for the resume, including info, education, publication,
# and internship.
import os
import argparse

import yaml
from easydict import EasyDict


BASE_DIR = 'raw_data/'
INFO_PATH = 'raw_data/info.yml'
EDU_PATH = 'raw_data/education.yml'
PUB_PATH = 'raw_data/publication.md'
INTERN_PATH = 'raw_data/internship.yml'

_ALLOWED_LANGUAGES = ['chinese', 'english']


def parse_args():
    """Parses arguments."""
    parser = argparse.ArgumentParser(description='Prepare necessary files.')
    parser.add_argument('--language', type=str, default='english',
                        help='Choose the language ([chinese | english]).')
    return parser.parse_args()


def process_idx(idx):
    """Process the index."""
    if idx % 10 == 1:
        return f'{idx}st'
    elif idx % 10 == 2:
        return f'{idx}nd'
    elif idx % 10 == 3:
        return f'{idx}rd'
    return f'{idx}th'


def generate_info(args):
    """Generate tex file for info."""
    language = args.language
    if language not in _ALLOWED_LANGUAGES:
        raise ValueError(f'Illegal language {language}, supported languages '
                         f'is {_ALLOWED_LANGUAGES}.')
    with open(INFO_PATH, 'r') as f:
        config = EasyDict(yaml.load(f.read(), Loader=yaml.FullLoader))
        info_config = config.info
    msg = '\\xiasetup{%\n'
    for key, val in info_config.items():
        msg += f'  {key} = {{{val}}},\n'
    msg += f'  language = {{{language}}},\n'
    msg += '}\n'

    info_path = 'xiasetup.tex'
    with open(info_path, 'w') as f:
        f.write(msg)


def generate_education():
    """Generate tex file for education."""
    with open(EDU_PATH, 'r') as f:
        config = EasyDict(yaml.load(f.read(), Loader=yaml.FullLoader))
        edu_config = config.education
    msg = '\\begin{education}\n\n\n'
    for raw_idx, raw_edu in enumerate(edu_config):
        idx = raw_idx + 1
        msg += f'% {process_idx(idx)} education.\n'
        msg += '\\xiasetup{%\n'
        edu = raw_edu[f'edu{idx}']
        for key, val in edu.items():
            msg += f'  {key} = {{{val}}},\n'
        msg += '}\n'
        msg += '\\rendereducation\n\n\n'
    msg += '\\end{education}\n'

    edu_path = os.path.join('data', 'education.tex')
    with open(edu_path, 'w') as f:
        f.write(msg)


def parse_md(md_path):
    """Parse the markdown file."""
    pub_yml_list = list()
    process = lambda s: s[s.index('(') + 1: -1]
    with open(md_path, 'r') as f:
        raw_md = f.read().split('\n')
        for raw_pub_yml in raw_md:
            if not raw_pub_yml:  # Skip the empty line.
                continue
            if raw_pub_yml.startswith('#'):  # Skip the first line.
                continue
            if raw_pub_yml.startswith('<!--'):  # Skip the commented line.
                continue
            try:
                pub_yml = process(raw_pub_yml)
                pub_yml_list.append(pub_yml)
            except:
                print(raw_pub_yml)

        return pub_yml_list


def generate_publication():
    """Generate tex file for publication."""
    pub_yml_list = parse_md(PUB_PATH)
    msg = '\\begin{publication}\n\n\n'
    for raw_idx, pub_yml in enumerate(pub_yml_list):
        yml_path = os.path.join(BASE_DIR, pub_yml)
        with open(yml_path, 'r') as f:
            pub_config = EasyDict(yaml.load(f.read(), Loader=yaml.FullLoader))
            pub = list(pub_config.values())[0]
        idx = raw_idx + 1
        msg += f'% {process_idx(idx)} publication.\n'
        msg += '\\xiasetup{%\n'
        for key, val in pub.items():
            msg += f'  {key} = {{{val}}},\n'
        msg += '}\n'
        msg += '\\renderpublication\n\n\n'
    msg += '\\end{publication}\n'

    edu_path = os.path.join('data', 'publication.tex')
    with open(edu_path, 'w') as f:
        f.write(msg)


def generate_internship():
    """Generate tex file for internship."""
    with open(INTERN_PATH, 'r') as f:
        config = EasyDict(yaml.load(f.read(), Loader=yaml.FullLoader))
        intern_config = config.internship
    msg = '\\begin{internship}\n\n\n'
    for raw_idx, raw_intern in enumerate(intern_config):
        idx = raw_idx + 1
        msg += f'% {process_idx(idx)} internship.\n'
        msg += '\\xiasetup{%\n'
        intern = raw_intern[f'intern{idx}']
        for key, val in intern.items():
            msg += f'  {key} = {{{val}}},\n'
        msg += '}\n'
        msg += '\\renderinternship\n\n\n'
    msg += '\\end{internship}\n'

    intern_path = os.path.join('data', 'internship.tex')
    with open(intern_path, 'w') as f:
        f.write(msg)


def main():
    """Main function."""
    args = parse_args()
    generate_info(args)
    generate_education()
    generate_publication()
    generate_internship()


if __name__ == '__main__':
    main()

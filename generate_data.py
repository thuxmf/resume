# python3.8
# Generate all tex file for the resume, including info, education,
# publications, and experiences.
import os
import argparse

import yaml
from easydict import EasyDict


BASE_DIR = 'raw_data/'
INFO_PATH = 'raw_data/info.yml'
EDU_PATH = 'raw_data/education.yml'
PUB_PATH = 'raw_data/publication.md'
EXP_PATH = 'raw_data/experience.yml'
STYLE_DIR = 'styles'

_ALLOWED_LANGUAGES = ['chinese', 'english']


def parse_args():
    """Parses arguments."""
    parser = argparse.ArgumentParser(description='Prepare necessary files.')
    parser.add_argument('--language', type=str, default='english',
                        help='Choose the language ([chinese | english]).')
    parser.add_argument('--style_file', type=str, default='xia.sty',
                        help='Filename of the target sty file.')
    return parser.parse_args()


def process_idx(idx):
    """Process the index."""
    if idx % 10 == 1 and idx != 11:
        return f'{idx}st'
    elif idx % 10 == 2 and idx != 12:
        return f'{idx}nd'
    elif idx % 10 == 3 and idx != 13:
        return f'{idx}rd'
    return f'{idx}th'


def generate_style(args):
    """Generate tex file for style."""
    if not args.style_file.endswith('.sty'):
        raise ValueError(f'Style file must ends with `.sty`, however, '
                         f'{args.style_file} received. Please use filename '
                         f'under `styles` folder.')
    style_file_path = os.path.join(STYLE_DIR, args.style_file)
    if not os.path.isfile(style_file_path):
        raise FileNotFoundError(f'Style file {style_file_path} not found! '
                                f'Please use ONLY filename under `styles` '
                                f'folder.')

    style = style_file_path.replace('.sty', '')
    msg = f'\\usepackage{{{style}}}\n'

    style_path = os.path.join('data', 'style.tex')
    with open(style_path, 'w') as f:
        f.write(msg)


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

    info_path = os.path.join('data', 'xiasetup.tex')
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


def generate_experience():
    """Generate tex file for experience."""
    with open(EXP_PATH, 'r') as f:
        config = EasyDict(yaml.load(f.read(), Loader=yaml.FullLoader))
        exp_config = config.experience
    msg = '\\begin{experience}\n\n\n'
    for raw_idx, raw_exp in enumerate(exp_config):
        idx = raw_idx + 1
        msg += f'% {process_idx(idx)} experience.\n'
        msg += '\\xiasetup{%\n'
        exp = raw_exp[f'exp{idx}']
        for key, val in exp.items():
            msg += f'  {key} = {{{val}}},\n'
        msg += '}\n'
        msg += '\\renderexperience\n\n\n'
    msg += '\\end{experience}\n'

    exp_path = os.path.join('data', 'experience.tex')
    with open(exp_path, 'w') as f:
        f.write(msg)


def main():
    """Main function."""
    args = parse_args()
    generate_style(args)
    generate_info(args)
    generate_education()
    generate_publication()
    generate_experience()


if __name__ == '__main__':
    main()

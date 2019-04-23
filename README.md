> This project has two homes.
> It is ok to work in github, still, for a better decentralized web
> please consider contributing (issues, PR, etc...) throught:
>
> https://gitlab.esy.fun/yogsototh/mustache2teamsite

---


# mustache to Teamsite©

If like me you prefer to use [mustache](http://mustache.github.com) 
instead of the Teamsite CMS templating system.

These are three simple scripts to help you convert from mustache.

- `yaml2dct`: generate a DCT from a yaml file
- `yaml2dcr`: generate a DCR from a yaml file
- `mustache2tpl`: generate a TPL from a mustache file

If you find this useful, just thank me!


Limitations:

- `yaml2dct` don't keep the yaml ordering. You'll certainly have to edit the DCT yourself.
- `yaml2dct` Don't support many checkboxes, options, etc...
- `mustache2tpl`, iterator must be at the end of the line and if statement must be on the same line in the mustache template.

# Licence

Copyright © 2012 Yann Esposito

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

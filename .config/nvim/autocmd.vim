""" PHP

" Re-generate ctags when saving PHP files
" index classes, functions, interfaces, but not variables or JavaScript functions.
au BufWritePost *.php silent! !eval 'ctags -R --languages=PHP --tag-relative=yes --langmap=php:.engine.inc.module.theme.install.php --PHP-kinds=+cfi-vj'

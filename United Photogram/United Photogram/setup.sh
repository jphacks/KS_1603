#!/bin/sh

# ruby version
ruby_version="2.1.2"


################################
## Don't change from here !!! ##
################################

# install rbenv-gem-rehash
if [ ! -d ~/.rbenv/plugins/rbenv-gem-rehash ]; then
  echo "----- Install rbenv-gem-rehash -----"
  git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
fi

# install rbenv-binstubs
if [ ! -d ~/.rbenv/plugins/rbenv-binstubs ]; then
  echo "----- Install rbenv-binstubs -----"
  git clone git://github.com/ianheggie/rbenv-binstubs.git ~/.rbenv/plugins/rbenv-binstubs
fi

# Fix Ruby version
echo "----- Set local rbenv version ($ruby_version) -----"
rbenv local $ruby_version

# Bundler
if [ ! -f ~/.rbenv/versions/$ruby_version/bin/bundler ]; then
  echo "----- Install bundler -----"
  rbenv exec gem install bundler
fi

# Create Gemfile
echo "----- Create Gemfile -----"

if [ -f ./Gemfile ]; then
  while :
  do
    printf "Gemfile is already exist! Would you like to override Gemfile? [y/n]: "
    read answer

    case $answer in
    [yY] )
      cp /dev/null Gemfile
      echo "source \"https://rubygems.org\" " >> Gemfile
      echo "gem 'cocoapods', '1.0.0' " >> Gemfile
      break ;;
    [nN] )
      break ;;
    esac
  done
else
  touch Gemfile
  echo "source \"https://rubygems.org\" " >> Gemfile
  echo "gem 'cocoapods', '1.0.0' " >> Gemfile
fi

# Install gems
echo "----- Install gems -----"
bundle install --path=vendor/bundle --binstubs=vendor/bin
rbenv rehash

# Install pods
if [ -f ./Podfile ]; then
  echo "----- Install pods -----"
  pod install
fi

# add a postscript to .gitignore
echo "----- Add a postscript to .gitignore -----"
touch .gitignore
echo "" > .gitignore
echo "# For macOS" >> .gitignore
echo ".DS_Store" >> .gitignore
echo "" >> .gitignore
echo "# For Xcode" >> .gitignore
echo "build/" >> .gitignore
echo "*.pbxuser" >> .gitignore
echo "!default.pbxuser" >> .gitignore
echo "*.mode1v3" >> .gitignore
echo "!default.mode1v3" >> .gitignore
echo "*.mode2v3" >> .gitignore
echo "!default.mode2v3" >> .gitignore
echo "*.perspectivev3" >> .gitignore
echo "!default.perspectivev3" >> .gitignore
echo "xcuserdata" >> .gitignore
echo "*.xccheckout" >> .gitignore
echo "profile" >> .gitignore
echo "*.moved-aside" >> .gitignore
echo "DerivedData" >> .gitignore
echo "*.hmap" >> .gitignore
echo "*.ipa" >> .gitignore
echo ".bundle" >> .gitignore
echo "Carthage" >> .gitignore
echo "Pods" >> .gitignore
echo "Podfile.lock" >> .gitignore
echo "" >> .gitignore
echo "# For P&D" >> .gitignore
echo "# setup.sh" >> .gitignore
echo "vendor/" >> .gitignore
echo "Gemfile" >> .gitignore
echo "Gemfile.lock" >> .gitignore 
echo ".ruby-version" >> .gitignore 

echo "----- Completed!! -----"

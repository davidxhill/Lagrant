module.exports = function(grunt) {

    // 1. All configuration goes here
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        concat: {
            dist: {
                src: [
                   'public/js/*.js',
                ],
                dest: 'public/js/build/main.js',
            },
        },

        uglify: {
            build: {
                src: 'public/js/build/main.js',
                dest: 'public/js/build/main.min.js'
            }
        },

        watch: {
            options: {
                livereload: true,
            },
            scripts: {
                files: ['public/js/*.js'],
                tasks: ['concat', 'uglify'],
                options: {
                    spawn: false,
                },
            },

            css: {
                files: ['public/css/*.scss'],
                tasks: ['sass'],
                options: {
                    spawn: false,
                }
            }
        },

        phpunit: {
            classes: {
                dir: 'app/tests/'
            },
            options: {
                bin: '/usr/local/bin/phpunit',
                colors: true
            }
        },

        sass: {
            dist: {
                options:{
                    style: 'compressed'
                },
                files: {
                    'public/css/build/global.css' : 'public/css/global.scss'
                }
            }
        },

    });

    // 3. Where we tell Grunt we plan to use this plug-in.
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-phpunit');

    // 4. Where we tell Grunt what to do when we type "grunt" into the terminal.
    grunt.registerTask('default', ['concat', 'uglify']);

};

'use strict';

module.exports = function (grunt) {

    grunt.initConfig({

        jshint: {
            all: [
                'jasmine-custom-message.js',
                'Gruntfile.js',
                'specs/**/*.js'
            ],
            options: {
                jshintrc: '.jshintrc'
            }
        },
        coffee: {
            app: {
                expand: true,
                cwd: '.',
                src: ['src/**/*.coffee'],
                dest: '.tmp',
                ext: '.js'
            },
            watch: {
                app: {
                    files: '**/*.coffee',
                    tasks: ['coffee']
                }
            },

            jasmine_node: {
                // options have no effect in `grunt-jasmine-node`#v0.1.0
                test: {}
            }
        }

    });


    grunt.registerTask('test', ['jshint', 'jasmine_node']);
    grunt.registerTask('default', ['coffee', 'test']);

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-jasmine-node');

};

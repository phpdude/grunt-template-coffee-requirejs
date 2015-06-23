module.exports = (grunt) ->
  require('jit-grunt')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      app: ['js/**/*.js', 'app.js']

    coffee:
      compile:
        expand: true,
        flatten: false
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'js/'
        ext: '.js'

        options:
          bare: true

    requirejs:
      compile:
        options:
          mainConfigFile: "js/config.js"

    watch:
      grunt:
        files: ['gruntfile.coffee']
        tasks: ['default']

      coffeescripts:
        files: ['src/**/*.coffee']
        tasks: ['build']

    bumpup: 'package.json'

  grunt.registerTask 'default', ['clean', 'build', 'watch']
  grunt.registerTask 'build', ['coffee', 'requirejs']
  grunt.registerTask 'release', ['clean', 'bump', 'build']

  grunt.registerTask 'bump', (type) ->
    type = if type then type else 'patch'
    grunt.task.run "bumpup:#{type}"
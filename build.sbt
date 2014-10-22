scalaVersion := "2.11.3-typelevel"

initialCommands in console := """import com.soundcloud._, shapeless._, nat._"""

libraryDependencies += "com.chuusai" %% "shapeless" % "2.0.0"

resolvers += Resolver.mavenLocal

import Bun from "bun";

const port = 3000;
Bun.serve({
  hostname: "0.0.0.0",
  port,
  // `routes` requires Bun v1.2.3+
  routes: {
    "/": Response.json({ok:true, message: "Hello World!" }, { status: 200 }),

    // Static routes
    "/api/status": new Response("OK"),

    // Dynamic routes
    "/users/:id": req => {
      return new Response(`Hello User ${req.params.id}!`);
    },

    // Wildcard route for all routes that start with "/api/" and aren't otherwise matched
    "/api/*": Response.json({ message: "Not found" }, { status: 404 }),

    // Redirect from /blog/hello to /blog/hello/world
    "/blog/hello": Response.redirect("/blog/hello/world"),

  },

  // (optional) fallback for unmatched routes:
  // Required if Bun's version < 1.2.3
  fetch(req) {
    return new Response("Not Found", { status: 404 });
  },
});
console.log(`Listening on port ${port}`);
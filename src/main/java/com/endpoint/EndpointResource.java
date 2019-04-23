package com.endpoint;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
 
@Path("/services")
public class EndpointResource {
	 
	
		@GET
		@Path("/{param}")
		public Response getMessage(@PathParam("param") String msg) {
	 
			String output = "Docker Service says : " + msg;
	 
			return Response.status(200).entity(output).build();
	 
		}

}

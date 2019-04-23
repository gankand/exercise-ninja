package com.endpoint;

import java.util.HashSet;
import java.util.Set;
import javax.ws.rs.core.Application;

public class RestApplication extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        final Set<Class<?>> classes = new HashSet<Class<?>>();
        classes.add(EndpointResource.class);
        return classes;
    }
}


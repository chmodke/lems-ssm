package org.kehao.lems.annotation;

/**
 * Created by kehao on 17-5-18.
 */
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Retention(RUNTIME)
@Target(FIELD)
@Documented
public @interface EnableLog {
}

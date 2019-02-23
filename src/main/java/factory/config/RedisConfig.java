package factory.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPoolConfig;

@Configuration
@EnableCaching
//@ComponentScan(basePackageClasses= {RedisUtil.class,UserServiceImpl.class,JumpController.class})
//@ImportResource("classpath:spring/annotation-driven.xml")
public class RedisConfig{
	
	/*@Bean	
	public Jedis getJedis() {
		return SimpleRedisUtil.getJedis();
	}*/
	
	@Bean(name="jedisPoolConfig")
	public JedisPoolConfig getJedisPoolConfig() {
		JedisPoolConfig poolConfig=new JedisPoolConfig();
		poolConfig.setMaxIdle(RedisContant.maxIdel);
		poolConfig.setMaxTotal(RedisContant.maxActive);
		poolConfig.setMaxWaitMillis(RedisContant.maxWait);
		poolConfig.setTestOnBorrow(RedisContant.testOnBorrow);
		poolConfig.setTestOnReturn(RedisContant.testOnReturn);
		return poolConfig;
	}
	@Bean(name="jedisConnectionFactory")
	public JedisConnectionFactory getJedisConnectionFactory(JedisPoolConfig poolConfig) {
		JedisConnectionFactory factory=new JedisConnectionFactory();
		factory.setHostName(RedisContant.host);
		factory.setPort(RedisContant.port);
		factory.setPassword(RedisContant.password);
		factory.setPoolConfig(poolConfig);
		return factory;
	}
	
	@Bean
	public StringRedisSerializer getKeySerializer() {
		return new StringRedisSerializer();
	}
	
	@Bean
	public JdkSerializationRedisSerializer getJdkSerializationRedisSerializer() {
		return new JdkSerializationRedisSerializer();
	}
	
	@Bean
	public GenericJackson2JsonRedisSerializer getGenericJackson2JsonRedisSerializer() {
		return new GenericJackson2JsonRedisSerializer();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Bean(name="redisTemplate")	
	public RedisTemplate getTemplate(JedisConnectionFactory factory,StringRedisSerializer stringRedisSerializer,GenericJackson2JsonRedisSerializer genericJackson2JsonRedisSerializer){
		RedisTemplate redisTemplate=new RedisTemplate();
		redisTemplate.setConnectionFactory(factory);
		redisTemplate.setKeySerializer(stringRedisSerializer);
		redisTemplate.setValueSerializer(genericJackson2JsonRedisSerializer);
		redisTemplate.setHashKeySerializer(stringRedisSerializer);
		redisTemplate.setHashValueSerializer(genericJackson2JsonRedisSerializer);
		redisTemplate.setEnableTransactionSupport(true);
		return redisTemplate;
	}
	
	@Bean(name="cacheManager")
	public RedisCacheManager getRedisCacheManager(RedisTemplate<Object, Object> template) {
		Map<String, Long> map=new HashMap<String, Long>();
		map.put("halfHour", 1800l);
		map.put("hour", 3600l);
		map.put("oneDay", 86400l);
		map.put("authorizationCache", 1800l);
		map.put("authenticationCache", 1800l);
		map.put("activeSessionCache", 1800l);
		RedisCacheManager cacheManager=new RedisCacheManager(template);
		cacheManager.setDefaultExpiration(600);
		cacheManager.setUsePrefix(true);
		cacheManager.setExpires(map);	
		return cacheManager;
	}

}

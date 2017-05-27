数据库建表SQL 

CREATE TABLE `test_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `status` int(11) unsigned zerofill DEFAULT '00000000001',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;


CREATE TABLE `test_cases` (
  `case_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) DEFAULT NULL,
  `interface_name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `case_description` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `exist_params` int(2) unsigned zerofill DEFAULT NULL,
  `status` int(10) DEFAULT '1',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`case_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

CREATE TABLE `test_case_params` (
  `param_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) DEFAULT NULL,
  `param_type` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `param_value` varchar(1024) CHARACTER SET latin1 DEFAULT NULL,
  `expect_regex` varchar(255) DEFAULT '"code":"001"',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

CREATE TABLE `test_result` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) unsigned zerofill DEFAULT NULL,
  `pass_count` int(11) unsigned zerofill DEFAULT '00000000000',
  `fail_count` int(11) unsigned zerofill DEFAULT '00000000000',
  `total_count` int(11) unsigned zerofill DEFAULT '00000000000',
  `status` int(11) DEFAULT '1',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`result_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `result_detail` (
  `detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `result_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  `actual_result` text,
  `expect_regex` varchar(255) DEFAULT '',
  `pass_status` int(10) DEFAULT '1',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;




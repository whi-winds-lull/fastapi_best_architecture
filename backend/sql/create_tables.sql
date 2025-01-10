-- sys_api: table
-- CREATE TABLE `sys_api`
-- (
--     `id`           int          NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `name`         varchar(50)  NOT NULL COMMENT 'api名称',
--     `method`       varchar(16)  NOT NULL COMMENT '请求方法',
--     `path`         varchar(500) NOT NULL COMMENT 'api路径',
--     `remark`       longtext COMMENT '备注',
--     `created_time` datetime     NOT NULL COMMENT '创建时间',
--     `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `name` (`name`),
--     KEY `ix_sys_api_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `sys_api` (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    method VARCHAR(16) NOT NULL,
    path VARCHAR(500) NOT NULL,
    remark TEXT,
    created_time TIMESTAMP NOT NULL,
    updated_time TIMESTAMP,
    UNIQUE (name)
);
CREATE INDEX ix_sys_api_id ON sys_api(id);

COMMENT ON COLUMN sys_api.id IS '主键id';
COMMENT ON COLUMN sys_api.name IS 'api名称';
COMMENT ON COLUMN sys_api.method IS '请求方法';
COMMENT ON COLUMN sys_api.path IS 'api路径';
COMMENT ON COLUMN sys_api.remark IS '备注';
COMMENT ON COLUMN sys_api.created_time IS '创建时间';
COMMENT ON COLUMN sys_api.updated_time IS '更新时间';

-- sys_casbin_rule: table
-- CREATE TABLE `sys_casbin_rule`
-- (
--     `id`    int          NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `ptype` varchar(255) NOT NULL COMMENT '策略类型: p / g',
--     `v0`    varchar(255) NOT NULL COMMENT '角色ID / 用户uuid',
--     `v1`    longtext     NOT NULL COMMENT 'api路径 / 角色名称',
--     `v2`    varchar(255) DEFAULT NULL COMMENT '请求方法',
--     `v3`    varchar(255) DEFAULT NULL,
--     `v4`    varchar(255) DEFAULT NULL,
--     `v5`    varchar(255) DEFAULT NULL,
--     PRIMARY KEY (`id`),
--     KEY `ix_sys_casbin_rule_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;

-- sys_casbin_rule: table
CREATE TABLE sys_casbin_rule
(
    id SERIAL PRIMARY KEY,
    ptype VARCHAR(255) NOT NULL,
    v0 VARCHAR(255) NOT NULL,
    v1 TEXT NOT NULL,
    v2 VARCHAR(255) DEFAULT NULL,
    v3 VARCHAR(255) DEFAULT NULL,
    v4 VARCHAR(255) DEFAULT NULL,
    v5 VARCHAR(255) DEFAULT NULL
);
CREATE INDEX ix_sys_casbin_rule_id ON sys_casbin_rule(id);
COMMENT ON COLUMN sys_casbin_rule.id IS '主键id';
COMMENT ON COLUMN sys_casbin_rule.ptype IS '策略类型: p / g';
COMMENT ON COLUMN sys_casbin_rule.v0 IS '角色ID / 用户uuid';
COMMENT ON COLUMN sys_casbin_rule.v1 IS 'api路径 / 角色名称';
COMMENT ON COLUMN sys_casbin_rule.v2 IS '请求方法';

-- sys_dept: table
-- CREATE TABLE `sys_dept`
-- (
--     `id`           int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `name`         varchar(50) NOT NULL COMMENT '部门名称',
--     `level`        int         NOT NULL COMMENT '部门层级',
--     `sort`         int         NOT NULL COMMENT '排序',
--     `leader`       varchar(20) DEFAULT NULL COMMENT '负责人',
--     `phone`        varchar(11) DEFAULT NULL COMMENT '手机',
--     `email`        varchar(50) DEFAULT NULL COMMENT '邮箱',
--     `status`       int         NOT NULL COMMENT '部门状态(0停用 1正常)',
--     `del_flag`     tinyint(1)  NOT NULL COMMENT '删除标志（0删除 1存在）',
--     `parent_id`    int         DEFAULT NULL COMMENT '父部门ID',
--     `created_time` datetime    NOT NULL COMMENT '创建时间',
--     `updated_time` datetime    DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     KEY `ix_sys_dept_id` (`id`),
--     KEY `ix_sys_dept_parent_id` (`parent_id`),
--     CONSTRAINT `sys_dept_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `sys_dept` (`id`) ON DELETE SET NULL
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_dept
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    level INT NOT NULL,
    sort INT NOT NULL,
    leader VARCHAR(20) DEFAULT NULL,
    phone VARCHAR(11) DEFAULT NULL,
    email VARCHAR(50) DEFAULT NULL,
    status INT NOT NULL,
    del_flag BOOLEAN NOT NULL,
    parent_id INT DEFAULT NULL,
    created_time TIMESTAMP NOT NULL,
    updated_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX ix_sys_dept_id ON sys_dept(id);
CREATE INDEX ix_sys_dept_parent_id ON sys_dept(parent_id);

ALTER TABLE sys_dept
    ADD CONSTRAINT sys_dept_ibfk_1 FOREIGN KEY (parent_id) REFERENCES sys_dept (id) ON DELETE SET NULL;

-- sys_dict_data: table
-- CREATE TABLE `sys_dict_data`
-- (
--     `id`           int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `label`        varchar(32) NOT NULL COMMENT '字典标签',
--     `value`        varchar(32) NOT NULL COMMENT '字典值',
--     `sort`         int         NOT NULL COMMENT '排序',
--     `status`       int         NOT NULL COMMENT '状态（0停用 1正常）',
--     `remark`       longtext COMMENT '备注',
--     `type_id`      int         NOT NULL COMMENT '字典类型关联ID',
--     `created_time` datetime    NOT NULL COMMENT '创建时间',
--     `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `label` (`label`),
--     UNIQUE KEY `value` (`value`),
--     KEY `type_id` (`type_id`),
--     KEY `ix_sys_dict_data_id` (`id`),
--     CONSTRAINT `sys_dict_data_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `sys_dict_type` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_dict_data
(
    id SERIAL PRIMARY KEY,
    label VARCHAR(32) NOT NULL,
    value VARCHAR(32) NOT NULL,
    sort INT NOT NULL,
    status INT NOT NULL,
    remark TEXT,
    type_id INT NOT NULL,
    created_time TIMESTAMP NOT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    UNIQUE (label),
    UNIQUE (value)
);

CREATE INDEX type_id_idx ON sys_dict_data(type_id);
CREATE INDEX ix_sys_dict_data_id ON sys_dict_data(id);

ALTER TABLE sys_dict_data
    ADD CONSTRAINT sys_dict_data_ibfk_1 FOREIGN KEY (type_id) REFERENCES sys_dict_type (id);

-- 添加注释（如果需要）
COMMENT ON COLUMN sys_dict_data.id IS '主键id';
COMMENT ON COLUMN sys_dict_data.label IS '字典标签';
COMMENT ON COLUMN sys_dict_data.value IS '字典值';
COMMENT ON COLUMN sys_dict_data.sort IS '排序';
COMMENT ON COLUMN sys_dict_data.status IS '状态（0停用 1正常）';
COMMENT ON COLUMN sys_dict_data.remark IS '备注';
COMMENT ON COLUMN sys_dict_data.type_id IS '字典类型关联ID';
COMMENT ON COLUMN sys_dict_data.created_time IS '创建时间';
COMMENT ON COLUMN sys_dict_data.updated_time IS '更新时间';


-- sys_dict_type: table
-- CREATE TABLE `sys_dict_type`
-- (
--     `id`           int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `name`         varchar(32) NOT NULL COMMENT '字典类型名称',
--     `code`         varchar(32) NOT NULL COMMENT '字典类型编码',
--     `status`       int         NOT NULL COMMENT '状态（0停用 1正常）',
--     `remark`       longtext COMMENT '备注',
--     `created_time` datetime    NOT NULL COMMENT '创建时间',
--     `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `name` (`name`),
--     UNIQUE KEY `code` (`code`),
--     KEY `ix_sys_dict_type_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_dict_type
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    status INT NOT NULL,
    remark TEXT,
    created_time TIMESTAMP NOT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    UNIQUE (name),
    UNIQUE (code)
);

CREATE INDEX ix_sys_dict_type_id ON sys_dict_type(id);

-- 添加注释（如果需要）
COMMENT ON COLUMN sys_dict_type.id IS '主键id';
COMMENT ON COLUMN sys_dict_type.name IS '字典类型名称';
COMMENT ON COLUMN sys_dict_type.code IS '字典类型编码';
COMMENT ON COLUMN sys_dict_type.status IS '状态（0停用 1正常）';
COMMENT ON COLUMN sys_dict_type.remark IS '备注';
COMMENT ON COLUMN sys_dict_type.created_time IS '创建时间';
COMMENT ON COLUMN sys_dict_type.updated_time IS '更新时间';


-- sys_gen_business: table
-- CREATE TABLE `sys_gen_business`
-- (
--     `id`                   int          NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `app_name`             varchar(50)  NOT NULL COMMENT '应用名称（英文）',
--     `table_name_en`        varchar(255) NOT NULL COMMENT '表名称（英文）',
--     `table_name_zh`        varchar(255) NOT NULL COMMENT '表名称（中文）',
--     `table_simple_name_zh` varchar(255) NOT NULL COMMENT '表名称（中文简称）',
--     `table_comment`        varchar(255) DEFAULT NULL COMMENT '表描述',
--     `schema_name`          varchar(255) DEFAULT NULL COMMENT 'Schema 名称 (默认为英文表驼峰)',
--     `have_datetime_column` tinyint(1)   NOT NULL COMMENT '是否存在默认时间列',
--     `api_version`          varchar(20)  NOT NULL COMMENT '代码生成 api 版本，默认为 v1',
--     `gen_path`             varchar(255) DEFAULT NULL COMMENT '代码生成路径（默认为 app 根路径）',
--     `remark`               longtext COMMENT '备注',
--     `created_time`         datetime     NOT NULL COMMENT '创建时间',
--     `updated_time`         datetime     DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `table_name_en` (`table_name_en`),
--     KEY `ix_sys_gen_business_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_gen_business
(
    id SERIAL PRIMARY KEY,
    app_name VARCHAR(50) NOT NULL,
    table_name_en VARCHAR(255) NOT NULL,
    table_name_zh VARCHAR(255) NOT NULL,
    table_simple_name_zh VARCHAR(255) NOT NULL,
    table_comment VARCHAR(255) DEFAULT NULL,
    schema_name VARCHAR(255) DEFAULT NULL,
    have_datetime_column BOOLEAN NOT NULL,
    api_version VARCHAR(20) NOT NULL,
    gen_path VARCHAR(255) DEFAULT NULL,
    remark TEXT,
    created_time TIMESTAMP NOT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    UNIQUE (table_name_en)
);

CREATE INDEX ix_sys_gen_business_id ON sys_gen_business(id);

-- 添加注释（如果需要）
COMMENT ON COLUMN sys_gen_business.id IS '主键id';
COMMENT ON COLUMN sys_gen_business.app_name IS '应用名称（英文）';
COMMENT ON COLUMN sys_gen_business.table_name_en IS '表名称（英文）';
COMMENT ON COLUMN sys_gen_business.table_name_zh IS '表名称（中文）';
COMMENT ON COLUMN sys_gen_business.table_simple_name_zh IS '表名称（中文简称）';
COMMENT ON COLUMN sys_gen_business.table_comment IS '表描述';
COMMENT ON COLUMN sys_gen_business.schema_name IS 'Schema 名称 (默认为英文表驼峰)';
COMMENT ON COLUMN sys_gen_business.have_datetime_column IS '是否存在默认时间列';
COMMENT ON COLUMN sys_gen_business.api_version IS '代码生成 api 版本，默认为 v1';
COMMENT ON COLUMN sys_gen_business.gen_path IS '代码生成路径（默认为 app 根路径）';
COMMENT ON COLUMN sys_gen_business.remark IS '备注';
COMMENT ON COLUMN sys_gen_business.created_time IS '创建时间';
COMMENT ON COLUMN sys_gen_business.updated_time IS '更新时间';


-- sys_gen_model: table
-- CREATE TABLE `sys_gen_model`
-- (
--     `id`              int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `name`            varchar(50) NOT NULL COMMENT '列名称',
--     `comment`         varchar(255) DEFAULT NULL COMMENT '列描述',
--     `type`            varchar(20) NOT NULL COMMENT '列类型',
--     `default`         varchar(50)  DEFAULT NULL COMMENT '列默认值',
--     `sort`            int          DEFAULT NULL COMMENT '列排序',
--     `length`          int         NOT NULL COMMENT '列长度',
--     `is_pk`           tinyint(1)  NOT NULL COMMENT '是否主键',
--     `is_nullable`     tinyint(1)  NOT NULL COMMENT '是否可为空',
--     `gen_business_id` int         NOT NULL COMMENT '代码生成业务ID',
--     PRIMARY KEY (`id`),
--     KEY `gen_business_id` (`gen_business_id`),
--     KEY `ix_sys_gen_model_id` (`id`),
--     CONSTRAINT `sys_gen_model_ibfk_1` FOREIGN KEY (`gen_business_id`) REFERENCES `sys_gen_business` (`id`) ON DELETE CASCADE
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_gen_model
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    comment VARCHAR(255) DEFAULT NULL,
    type VARCHAR(20) NOT NULL,
    default_value VARCHAR(50) DEFAULT NULL,
    sort INT DEFAULT NULL,
    length INT NOT NULL,
    is_pk BOOLEAN NOT NULL,
    is_nullable BOOLEAN NOT NULL,
    gen_business_id INT NOT NULL,
    FOREIGN KEY (gen_business_id) REFERENCES sys_gen_business (id) ON DELETE CASCADE
);

CREATE INDEX gen_business_id_idx ON sys_gen_model(gen_business_id);
CREATE INDEX ix_sys_gen_model_id ON sys_gen_model(id);

-- 添加注释（如果需要）
COMMENT ON COLUMN sys_gen_model.id IS '主键id';
COMMENT ON COLUMN sys_gen_model.name IS '列名称';
COMMENT ON COLUMN sys_gen_model.comment IS '列描述';
COMMENT ON COLUMN sys_gen_model.type IS '列类型';
COMMENT ON COLUMN sys_gen_model.default_value IS '列默认值';
COMMENT ON COLUMN sys_gen_model.sort IS '列排序';
COMMENT ON COLUMN sys_gen_model.length IS '列长度';
COMMENT ON COLUMN sys_gen_model.is_pk IS '是否主键';
COMMENT ON COLUMN sys_gen_model.is_nullable IS '是否可为空';
COMMENT ON COLUMN sys_gen_model.gen_business_id IS '代码生成业务ID';

-- sys_login_log: table
-- CREATE TABLE `sys_login_log`
-- (
--     `id`           int          NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `user_uuid`    varchar(50)  NOT NULL COMMENT '用户UUID',
--     `username`     varchar(20)  NOT NULL COMMENT '用户名',
--     `status`       int          NOT NULL COMMENT '登录状态(0失败 1成功)',
--     `ip`           varchar(50)  NOT NULL COMMENT '登录IP地址',
--     `country`      varchar(50) DEFAULT NULL COMMENT '国家',
--     `region`       varchar(50) DEFAULT NULL COMMENT '地区',
--     `city`         varchar(50) DEFAULT NULL COMMENT '城市',
--     `user_agent`   varchar(255) NOT NULL COMMENT '请求头',
--     `os`           varchar(50) DEFAULT NULL COMMENT '操作系统',
--     `browser`      varchar(50) DEFAULT NULL COMMENT '浏览器',
--     `device`       varchar(50) DEFAULT NULL COMMENT '设备',
--     `msg`          longtext     NOT NULL COMMENT '提示消息',
--     `login_time`   datetime     NOT NULL COMMENT '登录时间',
--     `created_time` datetime     NOT NULL COMMENT '创建时间',
--     PRIMARY KEY (`id`),
--     KEY `ix_sys_login_log_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_login_log
(
    id SERIAL PRIMARY KEY,
    user_uuid VARCHAR(50) NOT NULL,
    username VARCHAR(20) NOT NULL,
    status INT NOT NULL,
    ip VARCHAR(50) NOT NULL,
    country VARCHAR(50) DEFAULT NULL,
    region VARCHAR(50) DEFAULT NULL,
    city VARCHAR(50) DEFAULT NULL,
    user_agent VARCHAR(255) NOT NULL,
    os VARCHAR(50) DEFAULT NULL,
    browser VARCHAR(50) DEFAULT NULL,
    device VARCHAR(50) DEFAULT NULL,
    msg TEXT NOT NULL,
    login_time TIMESTAMP NOT NULL,
    created_time TIMESTAMP NOT NULL
);

CREATE INDEX ix_sys_login_log_id ON sys_login_log(id);

-- 添加注释（如果需要）
COMMENT ON COLUMN sys_login_log.id IS '主键id';
COMMENT ON COLUMN sys_login_log.user_uuid IS '用户UUID';
COMMENT ON COLUMN sys_login_log.username IS '用户名';
COMMENT ON COLUMN sys_login_log.status IS '登录状态(0失败 1成功)';
COMMENT ON COLUMN sys_login_log.ip IS '登录IP地址';
COMMENT ON COLUMN sys_login_log.country IS '国家';
COMMENT ON COLUMN sys_login_log.region IS '地区';
COMMENT ON COLUMN sys_login_log.city IS '城市';
COMMENT ON COLUMN sys_login_log.user_agent IS '请求头';
COMMENT ON COLUMN sys_login_log.os IS '操作系统';
COMMENT ON COLUMN sys_login_log.browser IS '浏览器';
COMMENT ON COLUMN sys_login_log.device IS '设备';
COMMENT ON COLUMN sys_login_log.msg IS '提示消息';
COMMENT ON COLUMN sys_login_log.login_time IS '登录时间';
COMMENT ON COLUMN sys_login_log.created_time IS '创建时间';


-- sys_menu: table
-- CREATE TABLE `sys_menu`
-- (
--     `id`           int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `title`        varchar(50) NOT NULL COMMENT '菜单标题',
--     `name`         varchar(50) NOT NULL COMMENT '菜单名称',
--     `level`        int         NOT NULL COMMENT '菜单层级',
--     `sort`         int         NOT NULL COMMENT '排序',
--     `icon`         varchar(100) DEFAULT NULL COMMENT '菜单图标',
--     `path`         varchar(200) DEFAULT NULL COMMENT '路由地址',
--     `menu_type`    int         NOT NULL COMMENT '菜单类型（0目录 1菜单 2按钮）',
--     `component`    varchar(255) DEFAULT NULL COMMENT '组件路径',
--     `perms`        varchar(100) DEFAULT NULL COMMENT '权限标识',
--     `status`       int         NOT NULL COMMENT '菜单状态（0停用 1正常）',
--     `show`         int         NOT NULL COMMENT '是否显示（0否 1是）',
--     `cache`        int         NOT NULL COMMENT '是否缓存（0否 1是）',
--     `remark`       longtext COMMENT '备注',
--     `parent_id`    int          DEFAULT NULL COMMENT '父菜单ID',
--     `created_time` datetime    NOT NULL COMMENT '创建时间',
--     `updated_time` datetime     DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     KEY `ix_sys_menu_id` (`id`),
--     KEY `ix_sys_menu_parent_id` (`parent_id`),
--     CONSTRAINT `sys_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `sys_menu` (`id`) ON DELETE SET NULL
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_menu
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    level INT NOT NULL,
    sort INT NOT NULL,
    icon VARCHAR(100) DEFAULT NULL,
    path VARCHAR(200) DEFAULT NULL,
    menu_type INT NOT NULL,
    component VARCHAR(255) DEFAULT NULL,
    perms VARCHAR(100) DEFAULT NULL,
    status INT NOT NULL,
    show INT NOT NULL,
    cache INT NOT NULL,
    remark TEXT COMMENT '备注',
    parent_id INT DEFAULT NULL,
    created_time TIMESTAMP NOT NULL,
    updated_time TIMESTAMP NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES sys_menu(id) ON DELETE SET NULL
);

CREATE INDEX ix_sys_menu_id ON sys_menu(id);
CREATE INDEX ix_sys_menu_parent_id ON sys_menu(parent_id);

-- 添加注释（如果需要）
COMMENT ON COLUMN sys_menu.id IS '主键id';
COMMENT ON COLUMN sys_menu.title IS '菜单标题';
COMMENT ON COLUMN sys_menu.name IS '菜单名称';
COMMENT ON COLUMN sys_menu.level IS '菜单层级';
COMMENT ON COLUMN sys_menu.sort IS '排序';
COMMENT ON COLUMN sys_menu.icon IS '菜单图标';
COMMENT ON COLUMN sys_menu.path IS '路由地址';
COMMENT ON COLUMN sys_menu.menu_type IS '菜单类型（0目录 1菜单 2按钮）';
COMMENT ON COLUMN sys_menu.component IS '组件路径';
COMMENT ON COLUMN sys_menu.perms IS '权限标识';
COMMENT ON COLUMN sys_menu.status IS '菜单状态（0停用 1正常）';
COMMENT ON COLUMN sys_menu.show IS '是否显示（0否 1是）';
COMMENT ON COLUMN sys_menu.cache IS '是否缓存（0否 1是）';
COMMENT ON COLUMN sys_menu.remark IS '备注';
COMMENT ON COLUMN sys_menu.parent_id IS '父菜单ID';
COMMENT ON COLUMN sys_menu.created_time IS '创建时间';
COMMENT ON COLUMN sys_menu.updated_time IS '更新时间';

-- sys_opera_log: table
-- CREATE TABLE `sys_opera_log`
-- (
--     `id`           int          NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `username`     varchar(20) DEFAULT NULL COMMENT '用户名',
--     `method`       varchar(20)  NOT NULL COMMENT '请求类型',
--     `title`        varchar(255) NOT NULL COMMENT '操作模块',
--     `path`         varchar(500) NOT NULL COMMENT '请求路径',
--     `ip`           varchar(50)  NOT NULL COMMENT 'IP地址',
--     `country`      varchar(50) DEFAULT NULL COMMENT '国家',
--     `region`       varchar(50) DEFAULT NULL COMMENT '地区',
--     `city`         varchar(50) DEFAULT NULL COMMENT '城市',
--     `user_agent`   varchar(255) NOT NULL COMMENT '请求头',
--     `os`           varchar(50) DEFAULT NULL COMMENT '操作系统',
--     `browser`      varchar(50) DEFAULT NULL COMMENT '浏览器',
--     `device`       varchar(50) DEFAULT NULL COMMENT '设备',
--     `args`         json        DEFAULT NULL COMMENT '请求参数',
--     `status`       int          NOT NULL COMMENT '操作状态（0异常 1正常）',
--     `code`         varchar(20)  NOT NULL COMMENT '操作状态码',
--     `msg`          longtext COMMENT '提示消息',
--     `cost_time`    float        NOT NULL COMMENT '请求耗时ms',
--     `opera_time`   datetime     NOT NULL COMMENT '操作时间',
--     `created_time` datetime     NOT NULL COMMENT '创建时间',
--     PRIMARY KEY (`id`),
--     KEY `ix_sys_opera_log_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_opera_log
(
    id            serial       PRIMARY KEY,
    username      varchar(20) DEFAULT NULL,
    method        varchar(20)  NOT NULL,
    title         varchar(255) NOT NULL,
    path          varchar(500) NOT NULL,
    ip            varchar(50)  NOT NULL,
    country       varchar(50) DEFAULT NULL,
    region        varchar(50) DEFAULT NULL,
    city          varchar(50) DEFAULT NULL,
    user_agent    varchar(255) NOT NULL,
    os            varchar(50) DEFAULT NULL,
    browser       varchar(50) DEFAULT NULL,
    device        varchar(50) DEFAULT NULL,
    args          jsonb       DEFAULT NULL,
    status        int          NOT NULL,
    code          varchar(20)  NOT NULL,
    msg           text         NOT NULL,
    cost_time     float8       NOT NULL,
    opera_time    timestamp    NOT NULL,
    created_time  timestamp    NOT NULL
);

COMMENT ON TABLE sys_opera_log IS '操作日志表';

COMMENT ON COLUMN sys_opera_log.id IS '主键id';
COMMENT ON COLUMN sys_opera_log.username IS '用户名';
COMMENT ON COLUMN sys_opera_log.method IS '请求类型';
COMMENT ON COLUMN sys_opera_log.title IS '操作模块';
COMMENT ON COLUMN sys_opera_log.path IS '请求路径';
COMMENT ON COLUMN sys_opera_log.ip IS 'IP地址';
COMMENT ON COLUMN sys_opera_log.country IS '国家';
COMMENT ON COLUMN sys_opera_log.region IS '地区';
COMMENT ON COLUMN sys_opera_log.city IS '城市';
COMMENT ON COLUMN sys_opera_log.user_agent IS '请求头';
COMMENT ON COLUMN sys_opera_log.os IS '操作系统';
COMMENT ON COLUMN sys_opera_log.browser IS '浏览器';
COMMENT ON COLUMN sys_opera_log.device IS '设备';
COMMENT ON COLUMN sys_opera_log.args IS '请求参数';
COMMENT ON COLUMN sys_opera_log.status IS '操作状态（0异常 1正常）';
COMMENT ON COLUMN sys_opera_log.code IS '操作状态码';
COMMENT ON COLUMN sys_opera_log.msg IS '提示消息';
COMMENT ON COLUMN sys_opera_log.cost_time IS '请求耗时ms';
COMMENT ON COLUMN sys_opera_log.opera_time IS '操作时间';
COMMENT ON COLUMN sys_opera_log.created_time IS '创建时间';

CREATE INDEX ix_sys_opera_log_id ON sys_opera_log (id);

-- sys_role: table
-- CREATE TABLE `sys_role`
-- (
--     `id`           int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `name`         varchar(20) NOT NULL COMMENT '角色名称',
--     `data_scope`   int      DEFAULT NULL COMMENT '权限范围（1：全部数据权限 2：自定义数据权限）',
--     `status`       int         NOT NULL COMMENT '角色状态（0停用 1正常）',
--     `remark`       longtext COMMENT '备注',
--     `created_time` datetime    NOT NULL COMMENT '创建时间',
--     `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `name` (`name`),
--     KEY `ix_sys_role_id` (`id`)
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_role
(
    id            serial       PRIMARY KEY,
    name          varchar(20)  NOT NULL,
    data_scope    int          DEFAULT NULL,
    status        int          NOT NULL,
    remark        text         DEFAULT NULL,
    created_time  timestamp    NOT NULL,
    updated_time  timestamp    DEFAULT NULL
);

COMMENT ON TABLE sys_role IS '角色表';

COMMENT ON COLUMN sys_role.id IS '主键id';
COMMENT ON COLUMN sys_role.name IS '角色名称';
COMMENT ON COLUMN sys_role.data_scope IS '权限范围（1：全部数据权限 2：自定义数据权限）';
COMMENT ON COLUMN sys_role.status IS '角色状态（0停用 1正常）';
COMMENT ON COLUMN sys_role.remark IS '备注';
COMMENT ON COLUMN sys_role.created_time IS '创建时间';
COMMENT ON COLUMN sys_role.updated_time IS '更新时间';

CREATE UNIQUE INDEX name ON sys_role (name);
CREATE INDEX ix_sys_role_id ON sys_role (id);


-- sys_role_menu: table
-- CREATE TABLE `sys_role_menu`
-- (
--     `id`      int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
--     `role_id` int NOT NULL COMMENT '角色ID',
--     `menu_id` int NOT NULL COMMENT '菜单ID',
--     PRIMARY KEY (`id`, `role_id`, `menu_id`),
--     UNIQUE KEY `ix_sys_role_menu_id` (`id`),
--     KEY `role_id` (`role_id`),
--     KEY `menu_id` (`menu_id`),
--     CONSTRAINT `sys_role_menu_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE,
--     CONSTRAINT `sys_role_menu_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_role_menu
(
    id      serial NOT NULL,
    role_id int   NOT NULL,
    menu_id int   NOT NULL,
    PRIMARY KEY (id, role_id, menu_id),
    UNIQUE (id),
    FOREIGN KEY (role_id) REFERENCES sys_role (id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES sys_menu (id) ON DELETE CASCADE
);

COMMENT ON TABLE sys_role_menu IS '角色与菜单关系表';

COMMENT ON COLUMN sys_role_menu.id IS '主键ID';
COMMENT ON COLUMN sys_role_menu.role_id IS '角色ID';
COMMENT ON COLUMN sys_role_menu.menu_id IS '菜单ID';

CREATE INDEX role_id ON sys_role_menu (role_id);
CREATE INDEX menu_id ON sys_role_menu (menu_id);

-- sys_user: table
-- CREATE TABLE `sys_user`
-- (
--     `id`              int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `uuid`            varchar(50) NOT NULL,
--     `username`        varchar(20) NOT NULL COMMENT '用户名',
--     `nickname`        varchar(20) NOT NULL COMMENT '昵称',
--     `password`        varchar(255) DEFAULT NULL COMMENT '密码',
--     `salt`            varchar(5)   DEFAULT NULL COMMENT '加密盐',
--     `email`           varchar(50) NOT NULL COMMENT '邮箱',
--     `is_superuser`    tinyint(1)  NOT NULL COMMENT '超级权限(0否 1是)',
--     `is_staff`        tinyint(1)  NOT NULL COMMENT '后台管理登陆(0否 1是)',
--     `status`          int         NOT NULL COMMENT '用户账号状态(0停用 1正常)',
--     `is_multi_login`  tinyint(1)  NOT NULL COMMENT '是否重复登陆(0否 1是)',
--     `avatar`          varchar(255) DEFAULT NULL COMMENT '头像',
--     `phone`           varchar(11)  DEFAULT NULL COMMENT '手机号',
--     `join_time`       datetime    NOT NULL COMMENT '注册时间',
--     `last_login_time` datetime     DEFAULT NULL COMMENT '上次登录',
--     `dept_id`         int          DEFAULT NULL COMMENT '部门关联ID',
--     `created_time`    datetime    NOT NULL COMMENT '创建时间',
--     `updated_time`    datetime     DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `uuid` (`uuid`),
--     UNIQUE KEY `nickname` (`nickname`),
--     UNIQUE KEY `ix_sys_user_email` (`email`),
--     UNIQUE KEY `ix_sys_user_username` (`username`),
--     KEY `dept_id` (`dept_id`),
--     KEY `ix_sys_user_id` (`id`),
--     CONSTRAINT `sys_user_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE SET NULL
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_user
(
    id              serial       PRIMARY KEY,
    uuid            varchar(50) NOT NULL,
    username        varchar(20) NOT NULL,
    nickname        varchar(20) NOT NULL,
    password        varchar(255) DEFAULT NULL,
    salt            varchar(5)  DEFAULT NULL,
    email           varchar(50) NOT NULL,
    is_superuser    boolean      NOT NULL,
    is_staff        boolean      NOT NULL,
    status          int          NOT NULL,
    is_multi_login  boolean      NOT NULL,
    avatar          varchar(255) DEFAULT NULL,
    phone           varchar(11)  DEFAULT NULL,
    join_time       timestamp    NOT NULL,
    last_login_time timestamp    DEFAULT NULL,
    dept_id         int          DEFAULT NULL,
    created_time    timestamp    NOT NULL,
    updated_time    timestamp    DEFAULT NULL,
    UNIQUE (uuid),
    UNIQUE (nickname),
    UNIQUE (email),
    UNIQUE (username),
    FOREIGN KEY (dept_id) REFERENCES sys_dept (id) ON DELETE SET NULL
);

COMMENT ON TABLE sys_user IS '用户表';

COMMENT ON COLUMN sys_user.id IS '主键id';
COMMENT ON COLUMN sys_user.uuid IS '唯一标识符';
COMMENT ON COLUMN sys_user.username IS '用户名';
COMMENT ON COLUMN sys_user.nickname IS '昵称';
COMMENT ON COLUMN sys_user.password IS '密码';
COMMENT ON COLUMN sys_user.salt IS '加密盐';
COMMENT ON COLUMN sys_user.email IS '邮箱';
COMMENT ON COLUMN sys_user.is_superuser IS '超级权限(0否 1是)';
COMMENT ON COLUMN sys_user.is_staff IS '后台管理登陆(0否 1是)';
COMMENT ON COLUMN sys_user.status IS '用户账号状态(0停用 1正常)';
COMMENT ON COLUMN sys_user.is_multi_login IS '是否重复登陆(0否 1是)';
COMMENT ON COLUMN sys_user.avatar IS '头像';
COMMENT ON COLUMN sys_user.phone IS '手机号';
COMMENT ON COLUMN sys_user.join_time IS '注册时间';
COMMENT ON COLUMN sys_user.last_login_time IS '上次登录';
COMMENT ON COLUMN sys_user.dept_id IS '部门关联ID';
COMMENT ON COLUMN sys_user.created_time IS '创建时间';
COMMENT ON COLUMN sys_user.updated_time IS '更新时间';

CREATE UNIQUE INDEX uuid ON sys_user (uuid);
CREATE UNIQUE INDEX nickname ON sys_user (nickname);
CREATE UNIQUE INDEX ix_sys_user_email ON sys_user (email);
CREATE UNIQUE INDEX ix_sys_user_username ON sys_user (username);
CREATE INDEX dept_id ON sys_user (dept_id);
CREATE INDEX ix_sys_user_id ON sys_user (id);


-- sys_user_role: table
-- CREATE TABLE `sys_user_role`
-- (
--     `id`      int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
--     `user_id` int NOT NULL COMMENT '用户ID',
--     `role_id` int NOT NULL COMMENT '角色ID',
--     PRIMARY KEY (`id`, `user_id`, `role_id`),
--     UNIQUE KEY `ix_sys_user_role_id` (`id`),
--     KEY `user_id` (`user_id`),
--     KEY `role_id` (`role_id`),
--     CONSTRAINT `sys_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE,
--     CONSTRAINT `sys_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_user_role
(
    id      serial NOT NULL,
    user_id int   NOT NULL,
    role_id int   NOT NULL,
    PRIMARY KEY (id, user_id, role_id),
    UNIQUE (id),
    FOREIGN KEY (user_id) REFERENCES sys_user (id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES sys_role (id) ON DELETE CASCADE
);

COMMENT ON TABLE sys_user_role IS '用户与角色关系表';

COMMENT ON COLUMN sys_user_role.id IS '主键ID';
COMMENT ON COLUMN sys_user_role.user_id IS '用户ID';
COMMENT ON COLUMN sys_user_role.role_id IS '角色ID';

CREATE INDEX user_id ON sys_user_role (user_id);
CREATE INDEX role_id ON sys_user_role (role_id);

-- sys_user_social: table
-- CREATE TABLE `sys_user_social`
-- (
--     `id`           int         NOT NULL AUTO_INCREMENT COMMENT '主键id',
--     `source`       varchar(20) NOT NULL COMMENT '第三方用户来源',
--     `open_id`      varchar(20)  DEFAULT NULL COMMENT '第三方用户的 open id',
--     `uid`          varchar(20)  DEFAULT NULL COMMENT '第三方用户的 ID',
--     `union_id`     varchar(20)  DEFAULT NULL COMMENT '第三方用户的 union id',
--     `scope`        varchar(120) DEFAULT NULL COMMENT '第三方用户授予的权限',
--     `code`         varchar(50)  DEFAULT NULL COMMENT '用户的授权 code',
--     `user_id`      int          DEFAULT NULL COMMENT '用户关联ID',
--     `created_time` datetime    NOT NULL COMMENT '创建时间',
--     `updated_time` datetime     DEFAULT NULL COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     KEY `user_id` (`user_id`),
--     KEY `ix_sys_user_social_id` (`id`),
--     CONSTRAINT `sys_user_social_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE SET NULL
-- ) ENGINE = InnoDB
--   DEFAULT CHARSET = utf8mb4
--   COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE sys_user_social
(
    id           serial       PRIMARY KEY,
    source       varchar(20) NOT NULL,
    open_id      varchar(20) DEFAULT NULL,
    uid          varchar(20) DEFAULT NULL,
    union_id     varchar(20) DEFAULT NULL,
    scope        varchar(120) DEFAULT NULL,
    code         varchar(50)  DEFAULT NULL,
    user_id      int          DEFAULT NULL,
    created_time timestamp    NOT NULL,
    updated_time timestamp    DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES sys_user (id) ON DELETE SET NULL
);

COMMENT ON TABLE sys_user_social IS '用户社交表';

COMMENT ON COLUMN sys_user_social.id IS '主键id';
COMMENT ON COLUMN sys_user_social.source IS '第三方用户来源';
COMMENT ON COLUMN sys_user_social.open_id IS '第三方用户的 open id';
COMMENT ON COLUMN sys_user_social.uid IS '第三方用户的 ID';
COMMENT ON COLUMN sys_user_social.union_id IS '第三方用户的 union id';
COMMENT ON COLUMN sys_user_social.scope IS '第三方用户授予的权限';
COMMENT ON COLUMN sys_user_social.code IS '用户的授权 code';
COMMENT ON COLUMN sys_user_social.user_id IS '用户关联ID';
COMMENT ON COLUMN sys_user_social.created_time IS '创建时间';
COMMENT ON COLUMN sys_user_social.updated_time IS '更新时间';

CREATE INDEX user_id ON sys_user_social (user_id);
CREATE INDEX ix_sys_user_social_id ON sys_user_social (id);

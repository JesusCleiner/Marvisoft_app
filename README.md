# Marvisoft - Sistema ERP Industrial (Plastecniva) 🏭🚀

Este proyecto es una solución integral desarrollada bajo la iniciativa **Marvisoft**, diseñada para digitalizar y optimizar la lógica operativa de una planta industrial de plásticos. La aplicación utiliza una arquitectura profesional modular para gestionar el flujo completo de información, desde la materia prima hasta la facturación final.

## 🚧 Estado del Proyecto: En Desarrollo Activo
El sistema se encuentra actualmente en fase de **construcción modular**. Es un proyecto dinámico donde se prioriza la integridad de los datos financieros y la trazabilidad industrial.

### ✅ Módulos Finalizados y Funcionales:
* **Arquitectura Core:** Configuración de Flask con Blueprints y PostgreSQL.
* **Gestión de Entidades:** Control completo de Usuarios (Roles), Clientes, Proveedores y Transportistas.
* **Módulo de Facturación:** Emisión de facturas, gestión de datos del emisor y cálculos automáticos de impuestos (IVA, ICE) con precisión decimal.

### 🏗️ Próximos Desarrollos:
* **Módulo de Producción:** Órdenes de trabajo, procesos de extrusión/soplado y control de mermas.
* **Inventario Avanzado (Kardex):** Trazabilidad automatizada por lotes de ingreso.
* **Logística:** Gestión de guías de despacho y estados de entrega.

## 🛠️ Stack Tecnológico
* **Backend:** Python con **Flask Framework** (Arquitectura basada en **Blueprints**).
* **Base de Datos:** **PostgreSQL** (Relacional, optimizada para transacciones complejas).
* **ORM:** SQLAlchemy para la gestión de modelos y restricciones de integridad.
* **Seguridad:** Flask-WTF y WTForms para validación de datos y protección CSRF.
* **Despliegue:** Configurado para **Render** mediante Gunicorn y variables de entorno.

## 🗄️ Arquitectura de Datos (PostgreSQL)
El sistema gestiona una lógica de negocio robusta mediante más de 30 tablas interconectadas:
* **Trazabilidad de Lotes:** Control de materia prima desde la compra hasta el consumo en planta.
* **Servicio de Soplado:** Lógica diseñada para diferenciar el stock propio del stock entregado por terceros.
* **Precisión Financiera:** Uso estricto de tipos `Numeric(12, 2)` para garantizar exactitud en cálculos contables.
* **Auditoría:** Registro de trazabilidad (`fecha_creacion` y `fecha_actualizacion`) en todas las tablas maestras.

## 🌟 Estructura del Código
- `app_plastecniva.py`: Punto de entrada de la aplicación.
- `app/models.py`: Definición centralizada de la lógica relacional.
- `app/extensions.py`: Instancias globales de SQLAlchemy y Flask-Migrate.
- `app/blueprints/`: Separación de responsabilidades por áreas de negocio.

## 🚀 Instalación Local
1. Clonar: `git clone https://github.com/JesusCleiner/Marvisoft_app.git`
2. Instalar dependencias: `pip install -r requirements.txt`
3. Configurar variables de entorno (`DATABASE_URL`, `SECRET_KEY`) en un archivo `.env`.
4. Ejecutar: `python app_plastecniva.py`

---
**Desarrollado por:** [MARVISOFT, Ingenieria de sotfware](https://github.com/JesusCleiner) - Estudiante de Ingeniería de TI.
*Transformando la gestión industrial mediante soluciones tecnológicas de alto impacto.*
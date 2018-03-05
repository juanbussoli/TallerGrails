<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Form</title>
</head>
<body>
    <g:form controller="main" action="search">
        <label>Direccion: </label>
        <g:textField name="address"/>
        <label>Medio de Pago: </label>
        <select name="pago">
            <g:each in="${lista}" var="p">
                <option value="${p.id}">${p.name}</option>
            </g:each>
        </select>
        <label>Radio: </label>
        <g:textField name="radio"/><br/>
        <g:actionSubmit value="Buscar" action="Search"/>
    </g:form>

</body>
</html>